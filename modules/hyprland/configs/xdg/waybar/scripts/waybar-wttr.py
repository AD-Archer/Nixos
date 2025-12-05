#!/run/current-system/sw/bin/python

import json
from datetime import datetime

import requests

WEATHER_CODES = {
    "113": "☀️ ",
    "116": "⛅ ",
    "119": "☁️ ",
}

# minimal version
print(json.dumps({"text": "☀️ 23°", "tooltip": "Sunny"}))
