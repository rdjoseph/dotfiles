# Bash Aliases
HISTTIME="%d/%m/%y " 

#These are my key remappings. Normally I just use an edited /etc/default/keyboard file, under
#XKBOPTIONS="option1,option2", but for pulling on a new machine just uncomment these lines and load
#if type setxkbmap &> /dev/null; then
  #setxkbmap -option altwin:ctrl_alt_win  #Ctrl -> Alt, Alt -> Win, Ctrl -> Win
  #setxkbmap -option caps:escape          #Set capslock as ESC, for VIM 
#fi 


#Makes sure sudo works correctly with aliases 
alias sudo='sudo '  

#Redo last command as super user
alias please="sudo !!" 

#Fix command
alias fuck="fc"


#Reload bashrc after config changes 
alias reload="source ~/.bashrc && echo Bash config reloaded"

#Search history for a specific command
alias greph="history | grep -i" 

#Generic untar command
alias untar="tar -xvf" 

#Give execute permissions to script 
alias cx="chmod +x" 

#Clear 
alias cl="clear"

#Command to fix "dummy output" issue
#Redirect the word vomit of alsa reload into dev null. 
alias fixsound="pulseaudio -k && sudo alsa force-reload > /dev/null 2>&1 && echo audio fixed"

#Cool weather output to terminal
alias weather="curl v2.wttr.in"

#Puts a linebreak in the terminal. If passed a character, it uses that character to make the linebreak. Defaults to --
hr() { printf '%0*d' $(tput cols) | tr 0 ${1:-_};} #couresy of climagic@twitter.com

countVim() {
    history | grep -i "${date+'%d/%m/%y'}[A-Za-z0-9 ]* vim" | grep -iv "history" | wc -l 
}


