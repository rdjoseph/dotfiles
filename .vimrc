"rdjoseph .vimrc 
"Standard of living settings- relative line number with objective line number on current line, syntax highlighting
:set rnu nu 
syntax on
"Make tabs work correctly 
"Tab now inserts 4 spaces, effectively
set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

"Make control-HJKL remap to window controls 
nnoremap <C-h> <C-w>h 
nnoremap <C-j> <C-w>j 
nnoremap <C-k> <C-w>k 
nnoremap <C-l> <C-w>l 

" Make vim use the system clipboard 
set clipboard=unnamed
set clipboard=unnamedplus

"Remap CAPSLOCK to ESC. This is done in bashrc because it requires a registry hack. But if you're pulling remotely and just want your CAPSLOCK to work as escape in just vim, uncomment the two below lines: 
"au VimEnter * :silent !setxkbmap -option caps:escape
"au VimLeave * :silent !setxkbmap -option #as a further note, just running plain -option resets all key mappings


" Fuzzy finding- :find something<TAB> can yield something.r even if its down a directory 
set path +=**

" Display all matching files when we tab complete- :find utils* will yield all matches. <Tab> forward and <S-Tab> back
set wildmenu 

" File browsing with netrw (preinstalled plugin, comes with vanilla vim
" :edit dir to open the browser 
let g:netrw_banner=0 "disable annoying banner
let g:netrw_browse_split=4 "open in prior window let g:netrw_altv=1 "open splits to right
let g:netrw_liststyle=3 "tree view 
let g:netrw_list_hide=netrw_gitignore#Hide() "Hide the .git folders
let g:netrw_list_hide.='.\(^\|\s\s\)\zs\.\S\+' "TODO: figure out what this actually does. Told to use it by a v clever vim guru


"SNIPPETS 
"Snippets are just expanded macros, or fast copy/paste. They allow you to paste in boilerplate with just a few strokes.
"The skeletons do pretty much what they say they do 
nnoremap <leader>html :-1read $HOME/.vim/.skeleton.html<CR>2jwf>a


"This is just for fun 
noremap <Up> :echo "Stop using arrow keys, jackass"<CR>
noremap <Down>  :echo "Stop using arrow keys, jackass"<CR>
noremap <Left> :echo "Stop using arrow keys, jackass"<CR>
noremap <Right> :echo "Stop using arrow keys, jackass"<CR>
