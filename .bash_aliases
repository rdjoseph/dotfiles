# Bash Aliases

#This makes my caps key an extra ESC key. This is to make VIM easier to use
#It must be done here and not in .vimrc because it's a registry hack.
#The if/else is just to suppress the warning for usage on remote systems 
#setxkbmap used in favor of xmodmap bc xmodmap is deprecated and hard to use
if type setxkbmap &> /dev/null; then
   setxkbmap -option caps:escape
fi 
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

