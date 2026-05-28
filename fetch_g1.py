import urllib.request
import re

url = "https://raw.githubusercontent.com/jbmballistics/jbmballistics/master/g1.txt"
try:
    response = urllib.request.urlopen("https://raw.githubusercontent.com/ntoll/pyshoot/master/pyshoot/g1.csv")
    print(response.read().decode('utf-8')[:500])
except Exception as e:
    print(e)

