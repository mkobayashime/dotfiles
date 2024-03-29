alias cp='cp -p'
alias df="df -h"
alias fusermount="fusermount -u"
alias rimraf="rm -rf"
alias pulseaudiorestart="pulseaudio --check && pulseaudio --kill && pulseaudio --start"
alias maek="make" # typo tolerance
hascommand icdiff && alias diff='icdiff'
isLinux && alias offmonitor='xset dpms force off'
