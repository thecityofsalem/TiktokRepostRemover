# made by salem, pls dont skid me im a shitty coder lol
import pyautogui
import time
import keyboard
import json
import os
import threading

# cfg settings
CONFIG_FILE = "config.salem"
DEFAULT_CONFIG = {
    "repost_pos": [1699, 357],
    "scroll_pos": [1336, 585],
    "scroll_delay": 0.4,
    "click_delay": 1.5
}

# create cfg
if not os.path.exists(CONFIG_FILE):
    with open(CONFIG_FILE, "w") as f:
        json.dump(DEFAULT_CONFIG, f, indent=4)
    print(f"Created new config file: {CONFIG_FILE}")

# load cfg
with open(CONFIG_FILE) as f:
    config = json.load(f)

# state
running = False
paused = False

def save_config():
    with open(CONFIG_FILE, "w") as f:
        json.dump(config, f, indent=4)


def click(position):
    x, y = position
    pyautogui.moveTo(x, y)
    pyautogui.click()
    time.sleep(config["click_delay"])

def main_loop():
    global running, paused
    running = True
    
    while running:
        if not paused:
            try:
                click(config["repost_pos"])
                click(config["scroll_pos"])
                time.sleep(config["scroll_delay"])
            except Exception as e:
                print(f"Error: {e}")
                break
        else:
            time.sleep(0.1)

# HOTKEYS
def toggle_operation():
    global running
    if not running:
        running = True
        threading.Thread(target=main_loop).start()
    else:
        running = False

def calibrate(position_type):
    x, y = pyautogui.position()
    config[f"{position_type}_pos"] = [x, y]
    save_config()
    print(f"{position_type.capitalize()} position set to {x},{y}")

keyboard.add_hotkey("f1", toggle_operation)
keyboard.add_hotkey("f2", lambda: globals().update(paused=not paused))
keyboard.add_hotkey("f3", lambda: calibrate("repost"))
keyboard.add_hotkey("f4", lambda: calibrate("scroll"))
keyboard.add_hotkey("ctrl+esc", lambda: os._exit(0))

print("""
salems awesome tiktok repost shit 
- F1: Start/Stop
- F2: Pause/Resume
- F3: Set Repost Position (hover + F3)
- F4: Set Scroll Position (hover + F4)
- Ctrl+Esc: Kill Program
""")

while True:
    time.sleep(1)