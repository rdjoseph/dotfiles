# Bash Aliases

xmodmap -e 'clear Lock' -e 'keycode 0x42=Escape'

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
alias fixsound="pulseaudio -k && sudo alsa force-reload && echo audio fixed"

#Cool weather output to terminal
alias weather="curl v2.wttr.in"


#C lang tooling stuff 
cc(){
    if [[ $1 == *.c ]]; then 
	    echo "Please do not include file extensions. Compilation & run aborted.\n"
    else
	    rm $1 > /dev/null 2>&1 #Redirects any error output to null so we don't see it  
	    gcc -Wall $1.c -o $1 
    fi 
}

crun(){
    cc $1
    ./$1
}

cdebug(){
    cc $1
    gbd ./$1
}


