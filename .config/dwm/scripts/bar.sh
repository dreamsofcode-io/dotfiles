#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/chadwm/scripts/bar_themes/catppuccin

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$green^ CPU"
	printf "^c$white^ ^b$grey^ $cpu_val"
}

pkg_updates() {
	# updates=$(doas xbps-install -un | wc -l) # void
	updates=$(checkupdates | wc -l)   # arch , needs pacman contrib
	# updates=$(aptitude search '~U' | wc -l)  # apt (ubuntu,debian etc)

	if [ -z "$updates" ]; then
		printf "^c$green^  Fully Updated"
	else
		printf "^c$green^  $updates"" updates"
	fi
}

battery() {
  capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
  state="$(cat /sys/class/power_supply/BAT0/status)"

  if [ "$state" = "Charging" ]; then
    if [ $capacity -ge 95 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 80 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 70 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 60 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 45 ]; then
      printf "^c$blue^ ^c$blue^  $capacity%%"
    elif [ $capacity -ge 25 ]; then
      printf "^c$blue^  $capacity%%"
    else
      printf "^c$blue^  $capacity%%"
    fi
  elif [ "$state" = "Full" ]; then
    printf "^c$blue^  $capacity%%"
  else
    if [ $capacity -ge 95 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 80 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 70 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 60 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 50 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 40 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 30 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 20 ]; then
      printf "^c$blue^  $capacity%%"
    elif [ $capacity -ge 10 ]; then
      printf "^c$blue^  $capacity%%"
    else
      printf "^c$blue^  $capacity%%"
    fi
  fi
}

brightness() {
	printf "^c$red^   "
	printf "^c$red^%.0f\n" $(cat /sys/class/backlight/*/brightness)
}

mem() {
	printf "^c$blue^^b$black^  "
	printf "^c$blue^ $(free -m | awk '/^Mem/ { printf "%.2f", $3 / $2 * 100 }' | sed s/i//g)%%"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$blue^Connected" ;;
	down) printf "^c$black^ ^b$blue^ 󰤭 ^d^%s" " ^c$blue^Disconnected" ;;
	esac
}

clock() {
	printf "^c$black^ ^b$darkblue^ 󱑆 "
	printf "^c$black^^b$blue^ $(date '+%R')  "
}

while true; do
	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
	interval=$((interval + 1))

	sleep 1 && xsetroot -name "$updates $(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock)"
done
