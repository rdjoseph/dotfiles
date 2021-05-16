"rdjoseph .vimrc 

"Standard of living settings- 
set rnu nu "Set relative line numbers, but display objective line number for current line 
syntax on 
set t_Co=256 "turn on 256 color display
set lazyredraw "Prevents unecessary screen redraws, like during macro intermediate steps. Gets rid of that jittery feel during macro execution
set hidden "Hides buffers instead of closing them, allowing one too switch buffers without writing them 

"Get vim to stop beeping at me like a pissed off cat
"Unfortunately there's no universal setting for this, and some options don't exist in certain versions 
"So this is my best attempt at quelling vim's most annoying feature
if exists('belloff')
    set belloff=all 
endif 

if exists('noerrorbells')
    set noerrorbells "This also disables vim's beeping, and seems to work on the Red Hat remote server I use where the prev option doesn't. 
endif

"Make tabs work correctly 
set expandtab     "tabs insert spaces
set shiftwidth=4  "makes shift command move 4 spaces
set tabstop=4     "number of spaces in a tab when rendering
set softtabstop=4 "number of spaces in a tab when inserting
set autoindent    "enter automatches indent of previous line
set smartindent   "make autoindent react to syntax.

" Normal mode CTRL keychords are for meta-movement: between windows, buffers, tabs. Also controlling those things. 
"Remap control-HJKL to moving between windows
nnoremap <C-h> <C-w>h 
nnoremap <C-j> <C-w>j 
nnoremap <C-k> <C-w>k 
nnoremap <C-l> <C-w>l 


"ctrl-N and ctrl-P to flip thru the buffer list 
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

"Make vim use the system clipboard 
set clipboard=unnamed
set clipboard=unnamedplus
if has("gui running") 
	set guifont=Ubuntu\ Mono\ 11
endif 

"Key remappings. 
"Normally, you want to edit /etc/default/keyboard and add options into the XKBOPTIONS string
"But if you're yanking on a remote sys and can't edit that, just uncomment these lines so it'll remap/demap on enter/exit
"au VimEnter * :silent !setxkbmap -option caps:escape "esc -> caps
"au VimEnter * :silent !setxkbmap -option altwin:ctrl_alt_win "ctrl->alt, alt->win, win->ctrl 
"au VimLeave * :silent !setxkbmap -option #as a further note, just running plain -option resets all key mappings

"?Remap '%%' to escape in normal mode. For use in norm commands
inoremap %% <ESC>

"File finding
set path +=** "Fuzzy finding- :find something<TAB> can yield something.r even if its down a directory 
set wildmenu " Display all matching files when we tab complete- :find utils* will yield all matches. <Tab> forward and <S-Tab> back

"SNIPPETS 
"Snippets are just expanded macros, or fast copy/paste. They allow you to paste in boilerplate with just a few strokes.
"The skeletons do pretty much what they say they do 
nnoremap <leader>html :-1read $HOME/.vim/.skeleton.html<CR>2jwf>a

" With much reluctance, I've begun to explore plugins...
" A list of my current plugins: 
"   Ale: Syntax checker 
packloadall 
silent! helptags ALL

noremap <Up> :echo "Stop using arrow keys, please"<CR>
noremap <Down>  :echo "Stop using arrow keys, please"<CR>
noremap <Left> :echo "Stop using arrow keys, please"<CR>
noremap <Right> :echo "Stop using arrow keys, please"<CR>

set foldmethod=indent

set modeline 
set modelines=5 


