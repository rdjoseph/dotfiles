# export GUILE_LOAD_PATH="/home/rdj/guile-3.0.5/guile-readline"

# Bash Aliases
HISTTIME="%d/%m/%y " 

#These are my key remappings. Normally I just use an edited /etc/default/keyboard file, under XKBOPTIONS="option1,option2", but for pulling on a new machine just uncomment these lines and load
#Sometimes an edited /etc/default/keyboard refuses to be loaded by xkb, in which case `gsettings reset org.gnome.desktop.input-sources xkb-options` will reset xkb and allow a reboot to read the config file. At least it worked once 
#if type setxkbmap &> /dev/null; then
  #setxkbmap -option ctrl:ralt_rctrl #Set AltGr as CTRL
  #setxkbmap -option caps:escape     #Set capslock as ESC, for VIM 
#fi 


#Makes sure sudo works correctly with aliases 
alias sudo='sudo '  

#Fix command
alias fuck="fc"


#Reload bashrc after config changes 
alias reload="source ~/.bashrc && echo Bash config reloaded"

#Search history for a specific command
alias greph="history | grep -i" 

#Generic untar command
alias untar="tar -xvf" 

#Clear 
alias cl="clear"

#This one's just stupid
alias jo='vim $(date "+%d.md") -c "setl tw=100 noautoindent nosmartindent"'

#(l)ast (m)inutes. Open last friday's minutes
alias lm='vi $(date --date="last Friday" +"%m-%d-%Y").md'
#(a)ll (m)inutes. Open all minutes
alias am='vi *.md'


#Command to fix "dummy output" issue
#Redirect the word vomit of alsa reload into dev null. 
alias fixsound="pulseaudio -k && sudo alsa force-reload > /dev/null 2>&1 && echo audio fixed"

bg(){
    $* > /dev/null 2>&1 &
}

libre(){
    libreoffice --writer $1 > /dev/null 2>&1 &
}

pdf(){
    evince $1 > /dev/null 2>&1 &

}

epub(){
    FBReader $1 > /dev/null 2>&1 &
}

#dumb pandoc wrapper for turning md -> docx 
convmd(){
    if [ -z "$2" ]; then
        IFS='.'
        declare -a split
        read -a split <<< "$1"
        pandoc -f markdown -t docx -o "$split".docx "$1"
    else
        pandoc -f markdown -t docx -o "$2".docx "$1"
    fi
    return 0
}



#Puts a linebreak in the terminal. If passed a character, it uses that character to make the linebreak. Defaults to --
hr() { printf '%0*d' $(tput cols) | tr 0 ${1:-_};} #couresy of climagic@twitter.com


#Taken from meyerweb.com's Polite Bash Commands, a chimeric cute bash function
please() {
    if [ "$1" ]; then
        sudo $@
    else 
        sudo "$BASH" -c "$(history -p !!)"
    fi 
}


sunrise(){
    p=3.14
    for i in $( seq 0 0.04 100 )
        do r=$( printf "128+127*s($i)\n" |bc -l |cut -d. -f1) g=$( printf "128+127*s($i+$p*(1/3))\n" |bc -l |cut -d. -f1 ) b=$( printf "128+127*s($i+$p*(2/3))\n" |bc -l |cut -d. -f1 )
        printf "\e[48;2;$r;$g;${b}m\n"
    done 
}

trap_exit(){
    clear 
    bash ~/see_you_space_cowboy.sh; sleep 5
    exit 
}

trap trap_exit EXIT 


