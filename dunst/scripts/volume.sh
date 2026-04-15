#!/bin/bash
# changeVolume

# Arbitrary but unique message tag
msgTag="myvolume"

# Change the volume using alsa(might differ if you use PulseAudio)
if [[ $1 == "add" ]]; then
  pamixer --increase "$2"
elif [[ $1 == "remove" ]]; then
  pamixer --decrease "$2"
elif [[ $1 == "mute" ]]; then
  pamixer -t
fi

# Query amixer for the current volume and whether or not the speaker is muted
volume="$(pamixer --get-volume)"
mute="$(pamixer --get-mute)"
if [[ $volume == 0 || "$mute" == true ]]; then
  # Show the sound muted notification
  dunstify -a "changeVolume" -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag "Volume muted"
else
  # Show the volume notification
  dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$volume" "Volume: ${volume}%"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
