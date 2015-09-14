#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL=
export VISUAL="vim"
export EDITOR="$VISUAL"
export ANDROID_HOME="$HOME/Library/Android/sdk/"
export JAVA_HOME=$(/usr/libexec/java_home)/a
export PATH="$PATH:$HOME/.bin:$ANDROID_HOME/tools/:$ANDROID_HOME/platform-tools/:$ANDROID_HOME/build-tools/"
alias vim="/usr/local/Cellar/macvim/7.4-77/MacVim.app/Contents/MacOS/Vim"
alias screenshot='adb -s $DEVICE shell "screencap /sdcard/screen.png"; adb -s $DEVICE pull /sdcard/screen.png; adb -s $DEVICE shell "rm -f /sdcard/screen.png"'
alias unlock='adb -s $DEVICE shell "input keyevent HOME; input tap 2250 1550; input text fingerprint; input keyevent 66"'
function tap {
  adb -s $DEVICE shell "input tap $1 $2"
}
function keyevent {
  adb -s $DEVICE shell "input keyevent $1"
}
function swipe {
  adb -s $DEVICE shell "input swipe $1 $2 $3 $4 $5"
}
function speech {
  say $@ -o file.aiff
  afconvert file.aiff -o file.m4a -f m4af
  adb -s $DEVICE push file.m4a /sdcard/file.m4a
  unlock
  adb -s $DEVICE shell am start -a android.intent.action.VIEW -d file:///sdcard/file.m4a -t audio/m4a; sleep 0.2; tap 1056 1298; sleep 10; keyevent POWER;
  adb -s $DEVICE shell rm -f /sdcard/file.m4a
}
