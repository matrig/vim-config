" Notes {
"   Personal .vimrc file of Mattia Rigotti
"}

" Environment {
   " Basics {
        set nocompatible            " must be first line
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Load pathogen {
        call pathogen#helptags()
        call pathogen#infect()
    " }
" }

" General {
    filetype plugin indent on       " automatically detect file types
    syntax on                       " switch syntax highlighting on, when the terminal has colors
    set mouse=a                     " enable mouse usage (all modes) in terminals

    " set autowrite                  " automatically write a file when leaving a modified buffer
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set history=1000                " keep 1000 lines of command line history
    "set spell                      " spell checking on
    set spelllang=en_us             " Set spelling language.

    set backup                      " Backups are nice
    set noswapfile

    if has('persistent_undo')
        set undofile                " So is persistent undo ...
        set undolevels=1000         " Maximum number of changes that can be undone
        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif

    if has("multi_byte")
        if &termencoding == ""
            let &termencoding = &encoding
        endif
        set encoding=utf-8
        setglobal fileencoding=utf-8
        "setglobal bomb
        set fileencodings=ucs-bom,utf-8,latin1
        set fillchars=vert:\│
    endif

    au FocusLost * :wa

    " This remembers where you were the last time you edited the file, and returns to the same position.
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


    " Only do this part when compiled with support for autocommands.
    if has("autocmd")
        " Enable file type detection.
        " Use the default filetype settings, so that mail gets 'tw' set to 72,
        " 'cindent' is on in C files, etc.
        filetype plugin on
        " Also load indent files, to automatically do language-dependent indenting.
        filetype indent on

        " For all text files set 'textwidth' to 72 characters.
        autocmd FileType text setlocal textwidth=72
        autocmd FileType cpp,c setlocal shiftwidth=4 omnifunc=ccomplete#Complete
        autocmd FileType python set omnifunc=pythoncomplete#Complete
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType html,xml set omnifunc=htmlcomplete#CompleteTags listchars-=tab:»·
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS
        autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
        autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    endif
" }

" Vim UI {
    set t_Co=256                    " enable 256 colors
    let g:solarized_termcolors=256
    set background=dark             " assume a dark background
    colorscheme ir_black "blackboard "mustang matlabdark  matlablight

    set showmode                    " display the current mode

    set cursorline                  " highlight current line
    " hi CursorLine guibg=#333333    " highlight bg color of current line

    if has("gui_running")
        if has("gui_gtk2")
            set guifont=Ubuntu\ Mono\ 10
        elseif has("gui_win32")
            set guifont=Consolas:h10:cANSI
        endif
    endif

    if has('cmdline_info')
        set ruler                   " show the ruler
        " set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
    endif

    set backspace=indent,eol,start  " allow backspacing over everything in insert mode
    set nu                          " show line numbers
    set showmatch                   " show matching brackets
    set incsearch                   " find as you type search
    set hlsearch                    " highlight words when searching for them.
    set ignorecase                  " ignore case in search patterns
    set smartcase                   " override ignorecase when pattern contains uppomnifunomnifunccomnifuncercase
    set smarttab                    " When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
    set wildmenu                    " magic for completion at the : command line"
    set wildmode=longest,list,full  " command <Tab> completion, list matches, then longest common part, then all.
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set sidescroll=5                " minimal number of columns to scroll horizontally
    set gdefault                    " the /g flag on :s substitutions by default
    set list
    "set listchars+=precedes:«,extends:» " strings to use in 'list' mode and commands to see tabs:
    "set listchars=tab:»·,trail:·,extends:▸,nbsp:.,eol:¬
    set listchars=tab:»·,trail:·,extends:▸,nbsp:.
    set hidden                      " Hide buffers when they are abandoned
    set laststatus=2                " occasions to show status line, 2=always
    set more
    set title                       " change the terminal's title
    set visualbell                  " don't beep
    set noerrorbells                " don't beep
    set ttyfast
    set nofoldenable
    set autochdir                   " Automatically set current directory as working directory
" }

" Formatting {
    set nowrap                      " wrapping makes windows look ugly
    "set wrap                        " wrap lines visually
    set linebreak                   " wrap at breakat characters
    set autoindent                  " always set autoindenting on
    "set colorcolumn=85             " Shows a colored columne at 85
    set diffopt+=iwhite             " ignore whitespaces in diffs
    set expandtab                   " use the appropriate number of spaces to insert a <tab>
    set tabstop=4                   " Better not to touch this
    set nojoinspaces                " No double spaces after a join command.
    set shiftwidth=4                " number of spaces to use for each (auto)indent step
    set shiftround                  " round indent to multiple of 'shiftwidth'
    set softtabstop=4               " let backspace delete indent
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" }

" Key (re)Mappings {
    " avoid having to press shift
    nnoremap ; :

    " change the mapleader from \ to ,
    let mapleader=","

    " jumps to the next row in the editor, instead of the wrap
    nnoremap j gj
    nnoremap k gk

    " clears the search buffer when you press ,/
    map <silent> ,/ :nohlsearch<CR>

    " let's you become sudo after loading, before saving
    cmap w!! w !sudo tee % >/dev/null

    " Toggle spell checking for the current buffer with Ctrl-i
    map <silent> <F6> :setlocal invspell<CR>
    imap <silent> <F6> <ESC>:setlocal invspell<CR>a

    " Look up the word under cursor in a dictionary
    "map <silent> <F12> b"*yw<Esc>:!/usr/bin/dict <C-R>* <bar> /usr/bin/colorit <bar> /usr/bin/less -R<CR>
    "imap <silent> <F12> <ESC>b"*yw<Esc>:!/usr/bin/dict <C-R>* <bar> /usr/bin/colorit <bar> /usr/bin/less -R<CR>a

    " Edit my BibTeX file
    " map <silent> <C-S-b> :e ~/Desktop/Dropbox/References/Biblio2005.bib<CR>

    " Use Q for formatting the current paragraph (or selection)
    vmap Q gq
    nmap Q gqap

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Make p in Visual mode replace the selected text with the "" register.
    vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

    "To use gw to swap the current word with the next, without changing cursor position:
    nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

    " Auto completion via \\ (instead of the nasty ctrl-x ctrl-o)
    " inoremap <leader>\ <C-x><C-o>
    " inoremap <tab> <c-r>=Smart_TabComplete()<CR>
    " inoremap <leader>\ <c-r>=Smart_TabComplete()<CR>

    " Quickly edit/reload the vimrc file
    nmap <silent> <leader>ev :e $MYVIMRC<CR>
    nmap <silent> <leader>sv :so $MYVIMRC<CR>

    " Remap ESC to jj
    inoremap jj <ESC>

    " Split screen vertically with \w
    " nnoremap <leader>w <C-w>v<C-w>l

    " Movement between split screens
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Toggle auto-indenting for code paste
    nnoremap <F2> :set invpaste paste?<CR>
    set pastetoggle=<F2>
" }

" Plugins {

    " OmniComplete {
        " If you prefer the Omni-Completion tip window to close when a selection is
        " made, these lines close it on movement in insert mode or when leaving
        " insert mode
        autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif
        set completeopt=menu,preview,longest
    " }

    " Latex {
        " Starting with Vim 7, the filetype of empty .tex files defaults to
        " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
        " The following changes the default filetype back to 'tex':
        " let g:tex_flavor='latex'
    " }

    " Ctags {
        " This will look in the current directory for 'tags', and work up the tree towards root until one is found.
        " (generate tags with: ctags -R -f ~/vimtags /usr/lib/python2.6/)
        set tags+=./tags;/,$HOME/vimtags
        " map <C-\>   :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " C-\ - Open the definition in a new tab
        " map <A-]>   :vsp <CR>:exec("tag ".expand("<cword>"))<CR>      " A-] - Open the definition in a vertical split
    " }

    " TagBar {
        map <F8>    :TagbarToggle<cr>
        let g:tagbar_left = 1
    " }

    " NERDCommentators {
        let NERDSpaceDelims = 1
    " }

    " Showmarks {
        " Showmarks disabled by default (toggle with \mt):
        let g:showmarks_enable=0
    " }

    " Syntastic {
        let g:syntastic_enable_signs=1
        let g:syntastic_quiet_warnings=1
    " }

    " python-mode {
        " Checking code every save
        let g:pymode_lint_write = 1
        " Switch pylint, pyflakes, pep8, mccabe code-checkers
        " Can have multiply values "pep8,pyflakes,mcccabe"
        let g:pymode_lint_checker = "pyflakes,mccabe"
        " Do not auto open cwindow if errors be found
        let g:pymode_lint_cwindow = 0
        let g:pymode_lint_ignore = "E226"
    " }

    " Easymotion {
        "let g:EasyMotion_leader_key = '<Tab>'
    " }

    " NerdTree {
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    " }

    " UndoTree {
        nnoremap <leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }

    " ctrlp {
        let g:ctrlp_working_path_mode = 2
        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$' }

        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': 'find %s -type f'
        \ }
    "}
" }

" My commands {
"    command RemoveTrailingWhitespace %s/\s\+$//e
" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }
