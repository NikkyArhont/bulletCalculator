import '/components/button_widget.dart';
import '/components/device_card_widget.dart';
import '/components/section_header_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'my_devices_model.dart';
import '/services/bluetooth_service.dart';
export 'my_devices_model.dart';

class MyDevicesWidget extends StatefulWidget {
  const MyDevicesWidget({super.key});

  static String routeName = 'myDevices';
  static String routePath = '/myDevices';

  @override
  State<MyDevicesWidget> createState() => _MyDevicesWidgetState();
}

class _MyDevicesWidgetState extends State<MyDevicesWidget> {
  late MyDevicesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyDevicesModel());
    
    // Start BLE scan on page enter
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BluetoothDeviceManager.instance.startScan();
    });
  }

  @override
  void dispose() {
    _model.dispose();
    BluetoothDeviceManager.instance.stopScan();
    super.dispose();
  }

  Widget _buildDeviceCard({
    required BuildContext context,
    required BluetoothDeviceModel device,
    required bool isConnected,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(6.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: isConnected
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(4.0),
                shape: BoxShape.rectangle,
              ),
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Icon(
                device.type == BluetoothDeviceType.kestrel
                    ? Icons.air_rounded
                    : device.type == BluetoothDeviceType.vectorOptics
                        ? Icons.straighten_rounded
                        : Icons.bluetooth_rounded,
                color: FlutterFlowTheme.of(context).primary,
                size: 24.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device.name,
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.spaceGrotesk(
                            fontWeight: FontWeight.bold,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          lineHeight: 1.2,
                        ),
                  ),
                  if (isConnected) ...[
                    const SizedBox(height: 4.0),
                    Builder(
                      builder: (context) {
                        final cache = BluetoothDeviceManager.instance.cache;
                        if (device.type == BluetoothDeviceType.kestrel) {
                          final parts = <String>[];
                          if (cache.windSpeed != null) parts.add('Ветер: ${cache.windSpeed}м/с');
                          if (cache.windDirection != null) parts.add('Направление: ${cache.windDirection}ч');
                          if (cache.temperature != null) parts.add('Т: ${cache.temperature}°C');
                          if (cache.pressure != null) parts.add('Давл: ${cache.pressure}гПа');
                          if (cache.humidity != null) parts.add('Влаж: ${cache.humidity}%');
                          
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                parts.isEmpty ? 'Данные еще не получены (ожидание сенсоров...)' : parts.join(', '),
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(),
                                      color: parts.isEmpty 
                                          ? FlutterFlowTheme.of(context).secondaryText 
                                          : FlutterFlowTheme.of(context).success,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              /* if (cache.lastRawKestrelData != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    cache.lastRawKestrelData!,
                                    style: TextStyle(fontSize: 9, color: Colors.grey, fontFamily: 'monospace'),
                                  ),
                                ), */
                            ],
                          );
                        } else if (device.type == BluetoothDeviceType.vectorOptics) {
                          final parts = <String>[];
                          if (cache.distance != null) parts.add('Дистанция: ${cache.distance}м');
                          if (cache.angle != null) parts.add('Угол: ${cache.angle}°');
                          
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                parts.isEmpty ? 'Измерения не поступали (сделайте замер)' : parts.join(', '),
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(),
                                      color: parts.isEmpty 
                                          ? FlutterFlowTheme.of(context).secondaryText 
                                          : FlutterFlowTheme.of(context).success,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              /* if (cache.lastRawVectorData != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    cache.lastRawVectorData!,
                                    style: TextStyle(fontSize: 9, color: Colors.grey, fontFamily: 'monospace'),
                                  ),
                                ), */
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      InkWell(
                        onTap: () {
                          BluetoothDeviceManager.instance.setDeviceType(device, BluetoothDeviceType.kestrel);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: device.type == BluetoothDeviceType.kestrel
                                ? FlutterFlowTheme.of(context).primary.withOpacity(0.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: device.type == BluetoothDeviceType.kestrel
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.air_rounded,
                                size: 12.0,
                                color: device.type == BluetoothDeviceType.kestrel
                                    ? FlutterFlowTheme.of(context).primary
                                    : FlutterFlowTheme.of(context).secondaryText,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                'Метеостанция',
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(),
                                      color: device.type == BluetoothDeviceType.kestrel
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context).secondaryText,
                                      fontSize: 10.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          BluetoothDeviceManager.instance.setDeviceType(device, BluetoothDeviceType.vectorOptics);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: device.type == BluetoothDeviceType.vectorOptics
                                ? FlutterFlowTheme.of(context).primary.withOpacity(0.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: device.type == BluetoothDeviceType.vectorOptics
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.straighten_rounded,
                                size: 12.0,
                                color: device.type == BluetoothDeviceType.vectorOptics
                                    ? FlutterFlowTheme.of(context).primary
                                    : FlutterFlowTheme.of(context).secondaryText,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                'Дальномер',
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(),
                                      color: device.type == BluetoothDeviceType.vectorOptics
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context).secondaryText,
                                      fontSize: 10.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            wrapWithModel(
              model: isConnected ? _model.buttonModel1 : _model.buttonModel2,
              updateCallback: () => safeSetState(() {}),
              child: ButtonWidget(
                content: isConnected ? 'Отключить' : 'Подключить',
                icon_present: false,
                icon_end_present: false,
                color: isConnected
                    ? FlutterFlowTheme.of(context).error
                    : FlutterFlowTheme.of(context).primary,
                variant: isConnected ? 'outline' : 'primary',
                size: 'small',
                full_width: false,
                loading: false,
                disabled: false,
                onPressed: () async {
                  if (isConnected) {
                    await BluetoothDeviceManager.instance.disconnect(device);
                  } else {
                    await BluetoothDeviceManager.instance.connect(device);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.safePop();
                            },
                          ),
                          Text(
                            'Добавление устройства',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.spaceGrotesk(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                  lineHeight: 1.2,
                                ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.help_outline_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: AnimatedBuilder(
                animation: BluetoothDeviceManager.instance,
                builder: (context, _) {
                  final manager = BluetoothDeviceManager.instance;
                  final connectedKestrel = manager.connectedKestrel;
                  final connectedVector = manager.connectedVector;
                  final scannedDevices = manager.scannedDevices;

                  return SingleChildScrollView(
                    primary: false,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [


                          // 2. Scan Status Header Card
                          Container(
                            margin: const EdgeInsets.only(bottom: 24.0),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(6.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Lottie.network(
                                        'https://dimg.dreamflow.cloud/v1/lottie/technical+radar+pulse+animation',
                                        width: 120.0,
                                        height: 120.0,
                                        fit: BoxFit.contain,
                                        animate: true,
                                      ),
                                      Icon(
                                        manager.isScanning
                                            ? Icons.bluetooth_searching_rounded
                                            : Icons.bluetooth_connected_rounded,
                                        color: FlutterFlowTheme.of(context).primary,
                                        size: 40.0,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    manager.isScanning ? 'Поиск устройств...' : 'Поиск завершен',
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          lineHeight: 1.2,
                                        ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    manager.isScanning
                                        ? 'Убедитесь, что Bluetooth включен'
                                        : 'Подключите найденные устройства из списка',
                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                          font: GoogleFonts.inter(),
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          lineHeight: 1.3,
                                        ),
                                  ),
                                  if (false) ...[
                                    const SizedBox(height: 8.0),
                                    Text(
                                      manager.scanDiagnostics,
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            font: GoogleFonts.inter(),
                                            color: manager.scanDiagnostics.contains('Ошибка') ||
                                                    manager.scanDiagnostics.contains('Внимание')
                                                ? FlutterFlowTheme.of(context).error
                                                : FlutterFlowTheme.of(context).success,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),

                          // 3. Connected Devices Section
                          if (connectedKestrel != null || connectedVector != null) ...[
                            wrapWithModel(
                              model: _model.sectionHeaderModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const SectionHeaderWidget(
                                title: 'ПОДКЛЮЧЕННЫЕ УСТРОЙСТВА',
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            if (connectedKestrel != null)
                              _buildDeviceCard(
                                context: context,
                                device: connectedKestrel,
                                isConnected: true,
                              ),
                            if (connectedVector != null)
                              _buildDeviceCard(
                                context: context,
                                device: connectedVector,
                                isConnected: true,
                              ),
                            const SizedBox(height: 16.0),
                          ],

                          // 4. Scanned/Available Devices Section
                          wrapWithModel(
                            model: _model.sectionHeaderModel,
                            updateCallback: () => safeSetState(() {}),
                            child: const SectionHeaderWidget(
                              title: 'ДОСТУПНЫЕ УСТРОЙСТВА',
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          
                          // Filter out already connected devices from scan list
                          if (scannedDevices
                              .where((d) =>
                                  d.id != connectedKestrel?.id &&
                                  d.id != connectedVector?.id)
                              .isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24.0),
                              child: Text(
                                manager.isScanning
                                    ? 'Поиск подходящего оборудования...'
                                    : 'Устройства не найдены. Убедитесь, что они включены и находятся в режиме сопряжения.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(),
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                    ),
                              ),
                            )
                          else
                            ...scannedDevices
                                .where((d) =>
                                    d.id != connectedKestrel?.id &&
                                    d.id != connectedVector?.id)
                                .map((device) => _buildDeviceCard(
                                      context: context,
                                      device: device,
                                      isConnected: false,
                                    )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          wrapWithModel(
                            model: _model.buttonModel4,
                            updateCallback: () => safeSetState(() {}),
                            child: ButtonWidget(
                              content: 'Обновить поиск',
                              icon: Icon(
                                Icons.refresh_rounded,
                                color: FlutterFlowTheme.of(context).onPrimary,
                                size: 16.0,
                              ),
                              icon_present: true,
                              icon_end_present: false,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              variant: 'primary',
                              size: 'large',
                              full_width: true,
                              loading: false,
                              disabled: false,
                              onPressed: () async {
                                await BluetoothDeviceManager.instance.startScan();
                              },
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              'Не видите ваше устройство?',
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                    lineHeight: 1.3,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
