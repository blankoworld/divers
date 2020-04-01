#!/usr/bin/env bash
#
# ps4asXbox
#
# Set a PS4 Controller as Xbox controller (for Stardew Valley for example)
#
# 1. sudo systemctl start bluetooth.service
# 2. bluetoothctl puis `power on`, `scan on` et `yes` si appairage
# 3. launch evtest program, check which number is suggested (i.e. 21)
# 4. launch ps4asXbox (this script) with the right previous number, i.e. 21
# 5. launch the game (i.e. Stardew Valley)

if [[ -z $1 ]]; then
  echo "Argument missing. Launch evtest and check which input/eventX number" \
    && exit 1
fi

number="$1"

sudo xboxdrv \
   --evdev /dev/input/event${number} \
   --evdev-absmap ABS_X=x1,ABS_Y=y1                 \
   --evdev-absmap ABS_Z=x2,ABS_RZ=y2                \
   --evdev-absmap ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y \
   --evdev-keymap BTN_A=x,BTN_B=a                   \
   --evdev-keymap BTN_C=b,BTN_X=y                   \
   --evdev-keymap BTN_Y=lb,BTN_Z=rb                 \
   --evdev-keymap BTN_TL=lt,BTN_TR=rt               \
   --evdev-keymap BTN_SELECT=tl,BTN_START=tr        \
   --evdev-keymap BTN_TL2=back,BTN_TR2=start        \
   --evdev-keymap BTN_MODE=guide                    \
   --axismap -y1=y1,-y2=y2                          \
   --mimic-xpad                                     \
   --silent

exit 0
