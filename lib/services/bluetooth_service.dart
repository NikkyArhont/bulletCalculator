import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

enum BluetoothDeviceType {
  kestrel,
  vectorOptics,
  unknown,
}

class BleDataCache {
  double? windSpeed;      // m/s
  int? windDirection;    // clock hour (1-12)
  double? temperature;    // °C
  double? pressure;       // hPa
  double? humidity;       // %
  double? windGust;       // m/s
  double? distance;       // meters
  double? angle;          // degrees
  DateTime? lastWeatherTime;
  DateTime? lastDistanceTime;
  String? lastRawKestrelData;
  String? lastRawVectorData;

  BleDataCache({
    this.windSpeed,
    this.windDirection,
    this.temperature,
    this.pressure,
    this.humidity,
    this.windGust,
    this.distance,
    this.angle,
    this.lastWeatherTime,
    this.lastDistanceTime,
  });

  void clear() {
    windSpeed = null;
    windDirection = null;
    temperature = null;
    pressure = null;
    humidity = null;
    windGust = null;
    distance = null;
    angle = null;
    lastWeatherTime = null;
    lastDistanceTime = null;
    lastRawKestrelData = null;
    lastRawVectorData = null;
  }
}

class BluetoothDeviceModel {
  final String id; // MAC on Android, UUID on iOS
  final String name;
  BluetoothDeviceType type;
  int rssi;
  bool isConnected;
  final BluetoothDevice? rawDevice; // Null in mock mode

  BluetoothDeviceModel({
    required this.id,
    required this.name,
    required this.type,
    this.rssi = -80,
    this.isConnected = false,
    this.rawDevice,
  });
}

class BluetoothDeviceManager extends ChangeNotifier {
  static final BluetoothDeviceManager instance = BluetoothDeviceManager._internal();

  BluetoothDeviceManager._internal() {
    _initMockTimer();
    _initAdapterStateListener();
  }

  void _initAdapterStateListener() {
    try {
      // Listening to adapterState stream initializes FBP tracking on Android/iOS
      FlutterBluePlus.adapterState.listen((state) {
        print('BLE: Bluetooth adapter state changed to $state');
      });
    } catch (e) {
      print('BLE: Error listening to adapter state: $e');
    }
  }

  String _scanDiagnostics = 'Готов к сканированию';
  String get scanDiagnostics => _scanDiagnostics;

  void _updateDiagnostics(String message) {
    _scanDiagnostics = message;
    notifyListeners();
    print('BLE Scan Status: $message');
  }

  bool _isScanning = false;
  bool get isScanning => _isScanning;

  bool _isMockMode = false; // Default to false since user has real devices now
  bool get isMockMode => _isMockMode;

  List<BluetoothDeviceModel> _scannedDevices = [];
  List<BluetoothDeviceModel> get scannedDevices => _scannedDevices;

  BluetoothDeviceModel? _connectedKestrel;
  BluetoothDeviceModel? get connectedKestrel => _connectedKestrel;

  BluetoothDeviceModel? _connectedVector;
  BluetoothDeviceModel? get connectedVector => _connectedVector;

  final BleDataCache cache = BleDataCache();

  StreamSubscription? _scanSubscription;
  final Map<String, StreamSubscription> _deviceStateSubscriptions = {};
  final Map<String, StreamSubscription> _notificationSubscriptions = {};

  Timer? _mockDataTimer;
  Timer? _kestrelPollTimer;

  void setDeviceType(BluetoothDeviceModel device, BluetoothDeviceType type) {
    device.type = type;
    
    // Update connected devices references if this device is connected
    if (device.isConnected) {
      if (type == BluetoothDeviceType.kestrel) {
        _connectedKestrel = device;
        if (_connectedVector?.id == device.id) _connectedVector = null;
        _startKestrelPolling(device);
      } else if (type == BluetoothDeviceType.vectorOptics) {
        _connectedVector = device;
        if (_connectedKestrel?.id == device.id) _connectedKestrel = null;
        _kestrelPollTimer?.cancel();
      } else {
        if (_connectedKestrel?.id == device.id) _connectedKestrel = null;
        if (_connectedVector?.id == device.id) _connectedVector = null;
        _kestrelPollTimer?.cancel();
      }
      
      // Discover services/setup notifications for the new type
      if (!_isMockMode && device.rawDevice != null) {
        _discoverAndSetupDevice(device);
      }
    }
    notifyListeners();
  }

  void _startKestrelPolling(BluetoothDeviceModel device) {
    _kestrelPollTimer?.cancel();
    _kestrelPollTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (device.isConnected && device.type == BluetoothDeviceType.kestrel && !_isMockMode) {
        final rawDevice = device.rawDevice;
        if (rawDevice == null) return;
        try {
          // Use servicesList to avoid performing an over-the-air service discovery on every tick.
          List<BluetoothService> services = rawDevice.servicesList;
          if (services.isEmpty) return;

          for (BluetoothService service in services) {
            for (BluetoothCharacteristic characteristic in service.characteristics) {
              final charUuid = characteristic.uuid.toString().toLowerCase();
              final isStandard = charUuid.contains('2a6e') ||
                  charUuid.contains('2a20') ||
                  charUuid.contains('2a6f') ||
                  charUuid.contains('2a6d') ||
                  charUuid.contains('2a72') ||
                  charUuid.contains('2a70') ||
                  charUuid.contains('2a71') ||
                  charUuid.contains('2a73');
              final isCustom = charUuid.contains('0310') ||
                  charUuid.contains('0320') ||
                  charUuid.contains('0330') ||
                  charUuid.contains('0350');

              if (isStandard || isCustom) {
                if (characteristic.properties.read) {
                  try {
                    final val = await characteristic.read().timeout(const Duration(seconds: 2));
                    if (isCustom) {
                      _parseKestrelCustomCharacteristic(charUuid, val);
                    } else {
                      _parseKestrelCharacteristic(charUuid, val);
                    }
                  } catch (e) {
                    print('Kestrel polling: Error reading char $charUuid: $e');
                  }
                }
              }
            }
          }
        } catch (e) {
          print('Kestrel polling error: $e');
        }
      } else {
        timer.cancel();
      }
    });
  }

  void toggleMockMode(bool value) {
    if (_isMockMode == value) return;
    _isMockMode = value;
    disconnectAll();
    _scannedDevices.clear();
    notifyListeners();
  }

  void _initMockTimer() {
    _mockDataTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_isMockMode) return;
      
      bool updated = false;
      final random = Random();

      if (_connectedKestrel != null) {
        // Simulate Kestrel updating weather metrics slightly
        cache.windSpeed = double.parse((2.0 + random.nextDouble() * 4.0).toStringAsFixed(1)); // 2 to 6 m/s
        cache.windGust = double.parse((cache.windSpeed! + random.nextDouble() * 2.0).toStringAsFixed(1));
        cache.windDirection = random.nextInt(12) + 1; // 1 to 12 o'clock
        cache.temperature = double.parse((18.0 + random.nextDouble() * 5.0).toStringAsFixed(1)); // 18 to 23 °C
        cache.pressure = double.parse((1005.0 + random.nextDouble() * 15.0).toStringAsFixed(1)); // 1005 to 1020 hPa
        cache.humidity = double.parse((40.0 + random.nextDouble() * 20.0).toStringAsFixed(1)); // 40% to 60%
        cache.lastWeatherTime = DateTime.now();
        updated = true;
      }

      if (_connectedVector != null) {
        // Vector Optics only registers when a shot measurement is fired (stimulated by click, or periodically here)
        // Let's simulate a click measurement every 12 seconds
        if (timer.tick % 3 == 0) {
          cache.distance = double.parse((100.0 + random.nextDouble() * 900.0).toStringAsFixed(0)); // 100 to 1000m
          cache.angle = double.parse((random.nextDouble() * 15.0 - 5.0).toStringAsFixed(1)); // -5° to +10°
          cache.lastDistanceTime = DateTime.now();
          updated = true;
        }
      }

      if (updated) {
        notifyListeners();
      }
    });
  }

  // Trigger distance measurement manually in mock mode
  void triggerMockRangefinderMeasurement() {
    if (!_isMockMode || _connectedVector == null) return;
    final random = Random();
    cache.distance = double.parse((200.0 + random.nextDouble() * 800.0).toStringAsFixed(0));
    cache.angle = double.parse((random.nextDouble() * 12.0 - 3.0).toStringAsFixed(1));
    cache.lastDistanceTime = DateTime.now();
    notifyListeners();
  }

  int _currentScanId = 0;

  Future<void> startScan() async {
    _currentScanId++;
    final myScanId = _currentScanId;

    if (_isScanning) {
      // Silently stop active scan and cancel previous subscription
      _isScanning = false;
      if (!_isMockMode) {
        try {
          await FlutterBluePlus.stopScan();
        } catch (e) {
          print('BLE Scan: Error stopping previous scan: $e');
        }
        await _scanSubscription?.cancel();
        _scanSubscription = null;
      }
    }
    
    _isScanning = true;
    _scannedDevices.clear();
    _updateDiagnostics('Подготовка к поиску...');

    if (_isMockMode) {
      _updateDiagnostics('Режим эмуляции: поиск...');
      // Return simulated devices after 1.5 seconds delay
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (myScanId != _currentScanId) return;
        if (!_isScanning) return;
        _scannedDevices = [
          BluetoothDeviceModel(id: 'MOCK_KESTREL_01', name: 'Kestrel 5700 #8291', type: BluetoothDeviceType.kestrel, rssi: -62),
          BluetoothDeviceModel(id: 'MOCK_VECTOR_02', name: 'Vector Paragon 6x21 BDC', type: BluetoothDeviceType.vectorOptics, rssi: -68),
        ];
        _isScanning = false;
        _updateDiagnostics('Эмуляция: найдено 2 устройства');
      });
      return;
    }

    try {
      // 1. Request location permission (mandatory for BLE scanning on Android)
      if (myScanId != _currentScanId) return;
      _updateDiagnostics('Проверка разрешений геолокации...');
      LocationPermission permission = await Geolocator.checkPermission();
      if (myScanId != _currentScanId) return;
      if (permission == LocationPermission.denied) {
        _updateDiagnostics('Запрос разрешений геолокации...');
        permission = await Geolocator.requestPermission();
      }
      if (myScanId != _currentScanId) return;
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        _updateDiagnostics('Ошибка: Гео-разрешение отклонено');
        _isScanning = false;
        notifyListeners();
        return;
      }
      print('BLE Scan: Location permission status: $permission');

      // Check Location services are enabled
      if (myScanId != _currentScanId) return;
      _updateDiagnostics('Проверка службы геолокации (GPS)...');
      bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
      if (myScanId != _currentScanId) return;
      if (!isGpsEnabled) {
        _updateDiagnostics('Внимание: Включите GPS (гео) на телефоне!');
        _isScanning = false;
        notifyListeners();
        return;
      }

      if (myScanId != _currentScanId) return;
      if (!await FlutterBluePlus.isSupported) {
        _updateDiagnostics('Ошибка: Bluetooth не поддерживается');
        _isScanning = false;
        notifyListeners();
        return;
      }

      if (myScanId != _currentScanId) return;
      _updateDiagnostics('Проверка состояния Bluetooth...');
      final adapterState = FlutterBluePlus.adapterStateNow;
      print('BLE Scan: Adapter state is $adapterState');

      if (myScanId != _currentScanId) return;
      if (adapterState == BluetoothAdapterState.off) {
        _updateDiagnostics('Включение Bluetooth...');
        try {
          await FlutterBluePlus.turnOn();
          // Wait briefly for adapter to turn on
          int waitCount = 0;
          while (FlutterBluePlus.adapterStateNow != BluetoothAdapterState.on && waitCount < 10) {
            if (myScanId != _currentScanId) return;
            await Future.delayed(const Duration(milliseconds: 200));
            waitCount++;
          }
        } catch (e) {
          _updateDiagnostics('Ошибка включения Bluetooth: $e');
        }

        if (myScanId != _currentScanId) return;
        if (FlutterBluePlus.adapterStateNow != BluetoothAdapterState.on) {
          _updateDiagnostics('Ошибка: Bluetooth выключен');
          _isScanning = false;
          notifyListeners();
          return;
        }
      } else if (adapterState == BluetoothAdapterState.unavailable) {
        _updateDiagnostics('Ошибка: Bluetooth недоступен');
        _isScanning = false;
        notifyListeners();
        return;
      }

      if (myScanId != _currentScanId) return;
      _updateDiagnostics('Запуск сканирования...');
      _scannedDevices.clear();
      
      _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        if (myScanId != _currentScanId) return;
        final activeResults = results.where((r) {
          final name = r.device.platformName.isNotEmpty ? r.device.platformName : r.advertisementData.advName;
          return name.isNotEmpty;
        }).toList();
        
        bool listChanged = false;

        for (ScanResult r in results) {
          final name = r.device.platformName.isNotEmpty ? r.device.platformName : r.advertisementData.advName;
          if (name.isEmpty) continue;

          final lowerName = name.toLowerCase();
          BluetoothDeviceType type = BluetoothDeviceType.unknown;

          // Check by name
          if (lowerName.contains('kestrel') || lowerName.contains('link') || lowerName.contains('heat')) {
            type = BluetoothDeviceType.kestrel;
          } else if (lowerName.contains('vector') || lowerName.contains('paragon') || lowerName.contains('laser') || lowerName.contains('range')) {
            type = BluetoothDeviceType.vectorOptics;
          }

          // Check by advertised service UUIDs
          if (type == BluetoothDeviceType.unknown) {
            final serviceUuids = r.advertisementData.serviceUuids.map((u) => u.toString().toLowerCase()).toList();
            if (serviceUuids.any((uuid) => uuid.contains('181a'))) {
              type = BluetoothDeviceType.kestrel;
              print('BLE Scan: Device "$name" matched Kestrel by environmental service UUID 181a!');
            }
          }

          final existingIndex = _scannedDevices.indexWhere((d) => d.id == r.device.remoteId.str);
          if (existingIndex != -1) {
            final oldDev = _scannedDevices[existingIndex];
            // Only rebuild UI if RSSI changed significantly (prevent layout thrashing) or type resolved
            if (oldDev.type != type || (oldDev.rssi - r.rssi).abs() > 8) {
              oldDev.rssi = r.rssi;
              oldDev.type = type;
              listChanged = true;
            }
          } else {
            _scannedDevices.add(BluetoothDeviceModel(
              id: r.device.remoteId.str,
              name: name,
              type: type,
              rssi: r.rssi,
              isConnected: false,
              rawDevice: r.device,
            ));
            listChanged = true;
          }
        }

        if (listChanged) {
          _updateDiagnostics('Поиск... Найдено приборов: ${activeResults.length}');
        }
      });

      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
      
      if (myScanId != _currentScanId) return;
      _updateDiagnostics('Поиск завершен. Найдено: ${_scannedDevices.length}');
    } catch (e) {
      if (myScanId != _currentScanId) return;
      _updateDiagnostics('Ошибка поиска: $e');
    }

    if (myScanId != _currentScanId) return;
    _isScanning = false;
    notifyListeners();
  }

  Future<void> stopScan() async {
    _currentScanId++; // Invalidate any running scan sessions
    if (!_isScanning) return;
    _isScanning = false;
    if (!_isMockMode) {
      try {
        await FlutterBluePlus.stopScan();
      } catch (e) {
        print('BLE Stop Scan Error: $e');
      }
      await _scanSubscription?.cancel();
      _scanSubscription = null;
    }
    notifyListeners();
  }

  Future<void> connect(BluetoothDeviceModel device) async {
    if (_isMockMode) {
      // Connect instantly in mock mode
      if (device.type == BluetoothDeviceType.kestrel) {
        if (_connectedKestrel != null) await disconnect(_connectedKestrel!);
        _connectedKestrel = device..isConnected = true;
        // Populate initial mock weather values
        cache.windSpeed = 3.2;
        cache.windGust = 4.5;
        cache.windDirection = 3; // 3 o'clock (90 degrees / East)
        cache.temperature = 21.5;
        cache.pressure = 1013.2;
        cache.humidity = 55.0;
        cache.lastWeatherTime = DateTime.now();
      } else if (device.type == BluetoothDeviceType.vectorOptics) {
        if (_connectedVector != null) await disconnect(_connectedVector!);
        _connectedVector = device..isConnected = true;
        // Populate initial mock distance values
        cache.distance = 500.0;
        cache.angle = 2.5;
        cache.lastDistanceTime = DateTime.now();
      }
      notifyListeners();
      _saveDeviceToPreferences(device);
      return;
    }

    final rawDevice = device.rawDevice;
    if (rawDevice == null) return;

    try {
      // Listen to connection state changes
      _deviceStateSubscriptions[device.id]?.cancel();
      _deviceStateSubscriptions[device.id] = rawDevice.connectionState.listen((state) async {
        if (state == BluetoothConnectionState.connected) {
          device.isConnected = true;
          if (device.type == BluetoothDeviceType.kestrel) {
            _connectedKestrel = device;
            _startKestrelPolling(device);
          } else if (device.type == BluetoothDeviceType.vectorOptics) {
            _connectedVector = device;
          }
          notifyListeners();
          
          // Discover services & setup data parsing
          _discoverAndSetupDevice(device);
        } else if (state == BluetoothConnectionState.disconnected) {
          device.isConnected = false;
          _cleanupDeviceResources(device.id);
          if (_connectedKestrel?.id == device.id) _connectedKestrel = null;
          if (_connectedVector?.id == device.id) _connectedVector = null;
          notifyListeners();
        }
      });

      await rawDevice.connect(timeout: const Duration(seconds: 15));
      _saveDeviceToPreferences(device);
    } catch (e) {
      print('BLE Connect Error: $e');
    }
  }

  Future<void> disconnect(BluetoothDeviceModel device) async {
    _deleteDeviceFromPreferences(device);
    if (device.type == BluetoothDeviceType.kestrel) {
      _kestrelPollTimer?.cancel();
    }
    if (_isMockMode) {
      device.isConnected = false;
      if (device.type == BluetoothDeviceType.kestrel) {
        _connectedKestrel = null;
      } else {
        _connectedVector = null;
      }
      notifyListeners();
      return;
    }

    final rawDevice = device.rawDevice;
    if (rawDevice == null) return;

    try {
      await rawDevice.disconnect();
    } catch (e) {
      print('BLE Disconnect Error: $e');
    }
    
    _cleanupDeviceResources(device.id);
    device.isConnected = false;
    if (_connectedKestrel?.id == device.id) _connectedKestrel = null;
    if (_connectedVector?.id == device.id) _connectedVector = null;
    notifyListeners();
  }

  void disconnectAll() {
    if (_isMockMode) {
      _connectedKestrel = null;
      _connectedVector = null;
      cache.clear();
      notifyListeners();
      return;
    }

    final devices = [_connectedKestrel, _connectedVector];
    for (var d in devices) {
      if (d != null) {
        disconnect(d);
      }
    }
  }

  Future<void> _discoverAndSetupDevice(BluetoothDeviceModel device) async {
    final rawDevice = device.rawDevice;
    if (rawDevice == null) return;

    try {
      _updateDiagnostics('Связь установлена. Ожидание готовности (1с)...');
      await Future.delayed(const Duration(milliseconds: 1000));
      _updateDiagnostics('Поиск служб...');
      List<BluetoothService> services = await rawDevice.discoverServices();
      
      // Form services summary for UI diagnostics
      List<String> diagList = [];
      for (var s in services) {
        final serviceUuid = s.uuid.toString().toLowerCase();
        final shortUuid = serviceUuid.length >= 8 ? serviceUuid.substring(4, 8) : serviceUuid;
        final chars = s.characteristics.map((c) {
          final charUuid = c.uuid.toString().toLowerCase();
          return charUuid.length >= 8 ? charUuid.substring(4, 8) : charUuid;
        }).join(',');
        diagList.add('$shortUuid:[$chars]');
      }
      _updateDiagnostics('Службы ${device.name}:\n${diagList.join(" | ")}');
      print('BLE Services discovered for ${device.name}: ${diagList.join(" | ")}');

      // If the device type is unknown, check services to promote/resolve its type dynamically
      if (device.type == BluetoothDeviceType.unknown) {
        bool isKestrel = false;
        final lowerName = device.name.toLowerCase();
        if (lowerName.contains('kestrel') || lowerName.contains('link') || lowerName.contains('heat')) {
          isKestrel = true;
        } else {
          for (BluetoothService service in services) {
            final serviceUuid = service.uuid.toString().toLowerCase();
            if (serviceUuid.contains('181a')) {
              isKestrel = true;
              break;
            }
          }
        }
        
        if (isKestrel) {
          device.type = BluetoothDeviceType.kestrel;
          _connectedKestrel = device;
          _startKestrelPolling(device);
          print('BLE Setup: Promoting unknown device "${device.name}" to Kestrel based on service discovery.');
        } else {
          device.type = BluetoothDeviceType.vectorOptics;
          _connectedVector = device;
          print('BLE Setup: Promoting unknown device "${device.name}" to Vector Optics (Rangefinder) based on service discovery.');
        }
        notifyListeners();
        _saveDeviceToPreferences(device);
      }

      for (BluetoothService service in services) {
        final serviceUuid = service.uuid.toString().toLowerCase();

        // 1. Kestrel Weather Station
        if (device.type == BluetoothDeviceType.kestrel) {
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            final charUuid = characteristic.uuid.toString().toLowerCase();
            final isStandard = charUuid.contains('2a6e') ||
                charUuid.contains('2a20') ||
                charUuid.contains('2a6f') ||
                charUuid.contains('2a6d') ||
                charUuid.contains('2a72') ||
                charUuid.contains('2a70') ||
                charUuid.contains('2a71') ||
                charUuid.contains('2a73');
            final isCustom = charUuid.contains('0310') ||
                charUuid.contains('0320') ||
                charUuid.contains('0330') ||
                charUuid.contains('0350');

            if (isStandard || isCustom) {
              try {
                if (characteristic.properties.notify || characteristic.properties.indicate) {
                  try {
                    await characteristic.setNotifyValue(true);
                    final sub = characteristic.lastValueStream.listen((value) {
                      if (isCustom) {
                        _parseKestrelCustomCharacteristic(charUuid, value);
                      } else {
                        _parseKestrelCharacteristic(charUuid, value);
                      }
                    });
                    _notificationSubscriptions['${device.id}_$charUuid'] = sub;
                  } catch (ne) {
                    print('Kestrel setup: notify failed for $charUuid: $ne');
                  }
                }
                if (characteristic.properties.read) {
                  final val = await characteristic.read().timeout(const Duration(seconds: 2));
                  if (isCustom) {
                    _parseKestrelCustomCharacteristic(charUuid, val);
                  } else {
                    _parseKestrelCharacteristic(charUuid, val);
                  }
                }
              } catch (e) {
                print('Kestrel setup: Error reading characteristic $charUuid: $e');
              }
            }
          }
        }

        // 2. Vector Optics Rangefinder
        if (device.type == BluetoothDeviceType.vectorOptics) {
          if (!serviceUuid.contains('1800') && !serviceUuid.contains('1801') && !serviceUuid.contains('180a') && !serviceUuid.contains('180f')) {
            BluetoothCharacteristic? writeChar;
            for (BluetoothCharacteristic characteristic in service.characteristics) {
              if (characteristic.properties.write || characteristic.properties.writeWithoutResponse) {
                writeChar = characteristic;
              }
              if (characteristic.properties.notify || characteristic.properties.indicate) {
                try {
                  await characteristic.setNotifyValue(true);
                  final charUuid = characteristic.uuid.toString().toLowerCase();
                  final sub = characteristic.lastValueStream.listen((value) {
                    _parseVectorOpticsNotification(value);
                  });
                  _notificationSubscriptions['${device.id}_$charUuid'] = sub;
                } catch (e) {
                  print('Vector Optics setup: Error setting up characteristic ${characteristic.uuid}: $e');
                }
              }
            }
            if (writeChar != null) {
              _sendVectorOpticsWakeupCommands(writeChar);
            }
          }
        }
      }

      // If we don't find standard 181a service on a Kestrel device, let's read custom ones for diagnostics
      bool hasStandardWeatherService = services.any((s) => s.uuid.toString().toLowerCase().contains('181a'));
      if (device.type == BluetoothDeviceType.kestrel && !hasStandardWeatherService) {
        _updateDiagnostics('Чтение кастомных сенсоров Kestrel...');
        List<String> customDataList = [];
        for (var service in services) {
          final serviceUuid = service.uuid.toString().toLowerCase();
          if (serviceUuid.contains('1800') || serviceUuid.contains('180a') || serviceUuid.contains('180f')) {
            continue; // Skip standard system services
          }
          for (var characteristic in service.characteristics) {
            final charUuid = characteristic.uuid.toString().toLowerCase();
            final shortUuid = charUuid.length >= 8 ? charUuid.substring(4, 8) : charUuid;
            if (characteristic.properties.read) {
              try {
                final val = await characteristic.read().timeout(const Duration(seconds: 2));
                final formatted = _formatRawBytes(val);
                customDataList.add('$shortUuid: $formatted');
                _updateDiagnostics('Kestrel кастом:\n${customDataList.join("\n")}');
              } catch (e) {
                customDataList.add('$shortUuid: ошибка чтения ($e)');
              }
            }
          }
        }
        print('Kestrel Custom Sensors Readout:\n${customDataList.join("\n")}');
      }
    } catch (e) {
      _updateDiagnostics('Ошибка настройки ${device.name}: $e');
      print('BLE Service Discovery/Setup Error for ${device.name}: $e');
    }
  }

  void _parseKestrelCharacteristic(String uuid, List<int> value) {
    if (value.isEmpty) return;

    try {
      final data = ByteData.sublistView(Uint8List.fromList(value));

      if (uuid.contains('2a6e')) {
        // Temperature (Celsius) - value is in 100ths of a deg C (Int16)
        if (value.length >= 2) {
          cache.temperature = data.getInt16(0, Endian.little) / 100.0;
          cache.lastWeatherTime = DateTime.now();
        }
      } else if (uuid.contains('2a20')) {
        // Temperature (Fahrenheit) - value is in 100ths of a degree (Int16)
        if (value.length >= 2) {
          final rawVal = data.getInt16(0, Endian.little) / 100.0;
          // If rawVal > 40, it's Fahrenheit. Convert to Celsius.
          if (rawVal > 40.0) {
            cache.temperature = double.parse(((rawVal - 32.0) * 5.0 / 9.0).toStringAsFixed(1));
          } else {
            cache.temperature = rawVal;
          }
          cache.lastWeatherTime = DateTime.now();
        }
      } else if (uuid.contains('2a6f')) {
        // Humidity (%) - value is in 100ths of a percent (Uint16)
        if (value.length >= 2) {
          cache.humidity = data.getUint16(0, Endian.little) / 100.0;
          cache.lastWeatherTime = DateTime.now();
        }
      } else if (uuid.contains('2a6d')) {
        // Pressure (Pascal or hPa) - value is in 10ths of a Pascal or 10ths of hPa (Uint32)
        if (value.length >= 4) {
          cache.pressure = data.getUint32(0, Endian.little) / 10.0; // In hPa
          cache.lastWeatherTime = DateTime.now();
        } else if (value.length >= 2) {
          cache.pressure = data.getUint16(0, Endian.little) / 10.0;
          cache.lastWeatherTime = DateTime.now();
        }
      } else if (uuid.contains('2a72') || uuid.contains('2a70')) {
        // Wind Speed (m/s) - value is in 100ths of m/s (Uint16)
        if (value.length >= 2) {
          cache.windSpeed = data.getUint16(0, Endian.little) / 100.0;
          cache.lastWeatherTime = DateTime.now();
        }
      } else if (uuid.contains('2a71') || uuid.contains('2a73')) {
        // Wind Direction (degrees) - value is in 100ths of a degree (Uint16)
        if (value.length >= 2) {
          final windDirDegrees = data.getUint16(0, Endian.little) / 100.0;
          // Convert to clock format (1-12)
          int hours = (windDirDegrees / 30.0).round();
          if (hours <= 0) hours += 12;
          if (hours > 12) hours -= 12;
          cache.windDirection = hours;
          cache.lastWeatherTime = DateTime.now();
        }
      }

      notifyListeners();
    } catch (e) {
      print('Kestrel characteristic parsing error: $e');
    }
  }

  double _parsePressureToHpa(int rawPress) {
    if (rawPress == 0xffff || rawPress <= 0) return 1013.25;

    final double pressVal = rawPress.toDouble();

    // 1. inHg * 100 (e.g. 2992 for 29.92 inHg) -> convert to hPa
    if (pressVal >= 2000 && pressVal <= 3500) {
      return double.parse(((pressVal / 100.0) * 33.8639).toStringAsFixed(1));
    }
    // 2. mmHg * 10 (e.g. 7600 for 760.0 mmHg) -> convert to hPa
    if (pressVal >= 5000 && pressVal <= 8500) {
      return double.parse(((pressVal / 10.0) * 1.333224).toStringAsFixed(1));
    }
    // 3. hPa * 10 (e.g. 10132 for 1013.2 hPa) -> convert to hPa
    if (pressVal >= 8000 && pressVal <= 12000) {
      return double.parse((pressVal / 10.0).toStringAsFixed(1));
    }
    // 4. inHg * 1000 (e.g. 29920 for 29.920 inHg) -> convert to hPa
    if (pressVal >= 20000 && pressVal <= 35000) {
      return double.parse(((pressVal / 1000.0) * 33.8639).toStringAsFixed(1));
    }
    // 5. mmHg * 100 (e.g. 53503 for 535.03 mmHg) -> convert to hPa
    if (pressVal >= 50000 && pressVal <= 85000) {
      return double.parse(((pressVal / 100.0) * 1.333224).toStringAsFixed(1));
    }

    // Fallback: assume hPa if it fits, or hPa * 10
    if (pressVal > 300 && pressVal < 1200) {
      return double.parse(pressVal.toStringAsFixed(1));
    }
    return double.parse((pressVal / 10.0).toStringAsFixed(1));
  }

  void _parseKestrelCustomCharacteristic(String uuid, List<int> value) {
    if (value.isEmpty) return;
    try {
      final hexString = value.map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
      cache.lastRawKestrelData = 'Kestrel $uuid: $hexString';
      
      final data = ByteData.sublistView(Uint8List.fromList(value));
      final cleanUuid = uuid.replaceAll('-', '').toLowerCase();

      // Check if it ends with '0310' or contains it
      if (cleanUuid.endsWith('0310') || cleanUuid.contains('0310')) {
        // Wind Direction: bytes 0-1 (Int16 little-endian, degrees * 10)
        if (value.length >= 2) {
          final rawDir = data.getInt16(0, Endian.little);
          if (rawDir != -32768 && rawDir != 32767) {
            int dirDegrees = (rawDir / 10.0).round();
            // Convert degrees to clock position (1-12)
            int clock = (dirDegrees / 30.0).round();
            if (clock == 0) clock = 12;
            cache.windDirection = clock;
          }
        }
        // Ambient Temp: bytes 2-3 (Int16, Celsius * 100)
        if (value.length >= 4) {
          final rawTemp = data.getInt16(2, Endian.little);
          if (rawTemp != -32768 && rawTemp != 32767) {
            cache.temperature = double.parse((rawTemp / 100.0).toStringAsFixed(1));
          }
        }
        // Wind speed: bytes 4-5 (Int16 little-endian, divided by 100)
        if (value.length >= 6) {
          final rawWind = data.getInt16(4, Endian.little);
          if (rawWind != -32768 && rawWind != 32767 && rawWind >= 0) {
            cache.windSpeed = double.parse((rawWind / 100.0).toStringAsFixed(1));
          } else if (rawWind == -32767 || rawWind == 32767 || rawWind == -32768) {
            cache.windSpeed = 0.0; // Invalid/No wind
          }
        }
        // Relative Humidity: bytes 6-7 (Uint16, 100ths of %)
        if (value.length >= 8) {
          final rawRH = data.getUint16(6, Endian.little);
          if (rawRH != 0xffff) {
            cache.humidity = double.parse((rawRH / 100.0).toStringAsFixed(1));
          }
        }
        // Station Pressure: bytes 8-9 (Uint16, 10ths of hPa)
        if (value.length >= 10) {
          final rawPress = data.getUint16(8, Endian.little);
          if (rawPress != 0xffff) {
            cache.pressure = double.parse((rawPress / 10.0).toStringAsFixed(1));
          }
        }
        cache.lastWeatherTime = DateTime.now();
      }
      notifyListeners();
    } catch (e) {
      print('BLE parsing custom Kestrel characteristic error: $e');
    }
  }

  String _formatRawBytes(List<int> value) {
    if (value.isEmpty) return 'empty';
    final hexString = value.map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
    try {
      final data = ByteData.sublistView(Uint8List.fromList(value));
      if (value.length == 2) {
        final i16 = data.getInt16(0, Endian.little);
        final u16 = data.getUint16(0, Endian.little);
        return 'HEX:$hexString Int16:$i16 Uint16:$u16';
      } else if (value.length == 4) {
        final i32 = data.getInt32(0, Endian.little);
        final f32 = data.getFloat32(0, Endian.little);
        return 'HEX:$hexString Int32:$i32 Float:${f32.toStringAsFixed(2)}';
      }
      return 'HEX:$hexString';
    } catch (e) {
      return 'HEX:$hexString (err:$e)';
    }
  }

  void _parseVectorOpticsNotification(List<int> value) {
    if (value.isEmpty) return;
    
    // Log raw data so it can be viewed in debugging console
    final hexString = value.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
    final asciiString = String.fromCharCodes(value.where((c) => c >= 32 && c <= 126));
    print('Vector Optics BLE Notification Received: HEX=[$hexString] ASCII=[$asciiString]');
    // Keep the last 3 unique packets for diagnostics
    final newHexString = 'HEX: $hexString\nASCII: $asciiString';
    List<String> currentPackets = cache.lastRawVectorData?.split('\n---\n') ?? [];
    if (!currentPackets.contains(newHexString)) {
      currentPackets.insert(0, newHexString);
      if (currentPackets.length > 3) currentPackets = currentPackets.sublist(0, 3);
      cache.lastRawVectorData = currentPackets.join('\n---\n');
    }

    try {
      // 1. Vector Optics 7E Binary Protocol
      // e.g., 7E 00 00 06 00 5E 00 3A 41 2B 0D 82 D7 7E
      if (value.length == 14 && value.first == 0x7E && value.last == 0x7E) {
        // Only parse if command byte (byte 3) is a measurement. We'll guess command 0x06 is NOT a measurement if it's static.
        // Actually, let's just parse it, but if we see multiple packet types, the user will tell us.
        final data = ByteData.sublistView(Uint8List.fromList(value));
        
        final distance = data.getFloat32(5, Endian.little);
        final angle = data.getInt16(9, Endian.little) / 100.0;

        cache.distance = double.parse(distance.toStringAsFixed(1));
        cache.angle = double.parse(angle.toStringAsFixed(1));
        cache.lastDistanceTime = DateTime.now();
        notifyListeners();
        return;
      }

      // 2. Check if it is ASCII formatted. Many hunting rangefinders output ASCII strings like:
      // "0034.50, 00.3" or "D:34.5, A:0.3"
      if (asciiString.contains(RegExp(r'\d'))) {
        // Regex search for distance
        final distMatch = RegExp(r'(?:dist|d|distance)?\s*[:=]?\s*([0-9.]+)\s*(?:m|yd)?', caseSensitive: false).firstMatch(asciiString);
        final angleMatch = RegExp(r'(?:angle|a|deg)?\s*[:=]?\s*(-?[0-9.]+)\s*(?:d|deg|°)?', caseSensitive: false).firstMatch(asciiString);
        
        if (distMatch != null) {
          cache.distance = double.tryParse(distMatch.group(1) ?? '');
        }
        if (angleMatch != null) {
          cache.angle = double.tryParse(angleMatch.group(1) ?? '');
        }

        if (cache.distance != null) {
          cache.lastDistanceTime = DateTime.now();
          notifyListeners();
          return;
        }
      }

      // 2. Binary Parsing fallback
      // Vector Optics/OEM boards often transmit: [Header, Dist_L, Dist_H, Angle_L, Angle_H, Checksum]
      // Or float-based structure (4 bytes distance, 4 bytes angle)
      if (value.length >= 6) {
        // Typical Chinese rangefinder serial format:
        // Byte 0: 0x55 (Sync/Header)
        // Byte 1: Type (e.g. 0x01)
        // Byte 2, 3: Distance in decimeters or centimeters
        // Byte 4, 5: Angle in 10ths of degree
        if (value[0] == 0x55 || value[0] == 0xAA) {
          final distDecimeters = (value[2] << 8) | value[3];
          final angleTenths = (value[4] << 8) | value[5];

          cache.distance = distDecimeters / 10.0; // convert to meters
          // Angle can be signed 16-bit
          int rawAngle = angleTenths;
          if (rawAngle > 32767) rawAngle -= 65536;
          cache.angle = rawAngle / 10.0;

          cache.lastDistanceTime = DateTime.now();
          notifyListeners();
          return;
        }
      }
    } catch (e) {
      print('Vector Optics parsing error: $e');
    }
  }

  Future<void> _sendVectorOpticsWakeupCommands(BluetoothCharacteristic characteristic) async {
    try {
      // Common wake-up/ACK sequences for Chinese BLE laser rangefinders
      final List<List<int>> wakeupCommands = [
        [0x7E, 0x00, 0x00, 0x00, 0x00, 0x7E], // Generic 7E empty packet/ACK
        [0x7E, 0x00, 0x00, 0x06, 0x00, 0x5E, 0x00, 0x3A, 0x41, 0x2B, 0x0D, 0x82, 0xD7, 0x7E], // Echo handshake
        [0x55, 0x04, 0x00, 0x00, 0x59], // SNDWAY stream enable
        [0x01], // Simple enable byte
        [0x41, 0x42], // "AB" (Applied Ballistics) string
      ];

      for (var cmd in wakeupCommands) {
        try {
          if (characteristic.properties.writeWithoutResponse) {
            await characteristic.write(cmd, withoutResponse: true);
          } else {
            await characteristic.write(cmd, withoutResponse: false);
          }
          await Future.delayed(const Duration(milliseconds: 300));
        } catch (e) {
          print('Error sending wake up cmd $cmd: $e');
        }
      }
    } catch (e) {
      print('Vector Optics Wakeup error: $e');
    }
  }

  void _cleanupDeviceResources(String deviceId) {
    _deviceStateSubscriptions[deviceId]?.cancel();
    _deviceStateSubscriptions.remove(deviceId);
    
    _kestrelPollTimer?.cancel();

    // Cancel notifications for this device
    final keysToCancel = _notificationSubscriptions.keys.where((k) => k.startsWith('${deviceId}_')).toList();
    for (var k in keysToCancel) {
      _notificationSubscriptions[k]?.cancel();
      _notificationSubscriptions.remove(k);
    }
  }

  Future<void> _saveDeviceToPreferences(BluetoothDeviceModel device) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('paired_${device.type.name}_id', device.id);
      await prefs.setString('paired_${device.type.name}_name', device.name);
    } catch (e) {
      print('Error saving BLE preferences: $e');
    }
  }

  Future<void> _deleteDeviceFromPreferences(BluetoothDeviceModel device) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('paired_${device.type.name}_id');
      await prefs.remove('paired_${device.type.name}_name');
    } catch (e) {
      print('Error deleting BLE preferences: $e');
    }
  }

  // Attempt to reconnect to previously connected devices
  Future<void> reconnectSavedDevices() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final kestrelId = prefs.getString('paired_kestrel_id');
      final kestrelName = prefs.getString('paired_kestrel_name');
      final vectorId = prefs.getString('paired_vectorOptics_id');
      final vectorName = prefs.getString('paired_vectorOptics_name');

      if (_isMockMode) {
        if (kestrelId != null && kestrelName != null) {
          connect(BluetoothDeviceModel(id: kestrelId, name: kestrelName, type: BluetoothDeviceType.kestrel, isConnected: false));
        }
        if (vectorId != null && vectorName != null) {
          connect(BluetoothDeviceModel(id: vectorId, name: vectorName, type: BluetoothDeviceType.vectorOptics, isConnected: false));
        }
        return;
      }

      // Real BLE autoconnect
      if (!await FlutterBluePlus.isSupported) return;

      if (kestrelId != null && kestrelName != null) {
        final device = BluetoothDevice(remoteId: DeviceIdentifier(kestrelId));
        connect(BluetoothDeviceModel(
          id: kestrelId,
          name: kestrelName,
          type: BluetoothDeviceType.kestrel,
          rawDevice: device,
        ));
      }

      if (vectorId != null && vectorName != null) {
        final device = BluetoothDevice(remoteId: DeviceIdentifier(vectorId));
        connect(BluetoothDeviceModel(
          id: vectorId,
          name: vectorName,
          type: BluetoothDeviceType.vectorOptics,
          rawDevice: device,
        ));
      }
    } catch (e) {
      print('Error autoconnecting devices: $e');
    }
  }

  @override
  void dispose() {
    _mockDataTimer?.cancel();
    _kestrelPollTimer?.cancel();
    stopScan();
    disconnectAll();
    super.dispose();
  }
}
