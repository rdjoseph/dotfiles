"rdjoseph .vimrc 

"Standard of living settings- 
set rnu nu "Set relative line numbers, but display objective line number for current line 
set belloff=all "Disable vim's beeping. Sorry VIM, you've almost deafened me trying to jam in my headphones way too many times. 
syntax on 
set t_Co=256 "turn on 256 color display
set lazyredraw "Prevents unecessary screen redraws, like during macro intermediate steps. Gets rid of that jittery feel during macro execution

"Make tabs work correctly 
set expandtab     "tabs insert spaces
set shiftwidth=4  "makes shift command move 4 spaces
set tabstop=4     "number of spaces in a tab when rendering
set softtabstop=4 "number of spaces in a tab when inserting
set autoindent    "enter automatches indent of previous line
set smartindent   "make autoindent react to syntax.

"Make control-HJKL remap to window controls 
nnoremap <C-h> <C-w>h 
nnoremap <C-j> <C-w>j 
nnoremap <C-k> <C-w>k 
nnoremap <C-l> <C-w>l 

"Make vim use the system clipboard 
set clipboard=unnamed
set clipboard=unnamedplus
if has("gui running") 
	set guifont=Ubuntu\ Mono\ 11
endif 

"Remap CAPSLOCK to ESC. This is done in bashrc because it requires a registry hack. But if you're pulling remotely and just want your CAPSLOCK to work as escape in just vim, uncomment the two below lines: 
"au VimEnter * :silent !setxkbmap -option caps:escape
"au VimLeave * :silent !setxkbmap -option #as a further note, just running plain -option resets all key mappings

"?Remap '%%' to escape in normal mode. For use in ex's norm commands
inoremap %% <ESC>

"File finding
set path +=** "Fuzzy finding- :find something<TAB> can yield something.r even if its down a directory 
set wildmenu " Display all matching files when we tab complete- :find utils* will yield all matches. <Tab> forward and <S-Tab> back

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
noremap <Up> :echo "Stop using arrow keys, please"<CR>
noremap <Down>  :echo "Stop using arrow keys, please"<CR>
noremap <Left> :echo "Stop using arrow keys, please"<CR>
noremap <Right> :echo "Stop using arrow keys, please"<CR>
