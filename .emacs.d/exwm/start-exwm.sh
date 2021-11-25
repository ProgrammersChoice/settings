#!/bin/sh
#xrdb ~/.emacs.d/exwm/Xresources

# Run the screen compositor
compton &

# Enable screen locking on suspend
xss-lock -- slock &

exec dbus-launch --exit-with-session emacs -mm --debug-init -l ~/.emacs.d/desktop.el
