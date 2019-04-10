" File: init.vim
" Author: Daniel Etrata
" Description: 
" We will only try to load filetype specific plugins accordingly.
" To navigate the folds,  {up:'zk', down:'zj',
" open all one fold level:'zr', close all one fold level:'zm',
" toggle fold level:'za'}
" Last Modified: December 20, 2016
" General Guidelines:
" We will try to follow this format for settings.
" [autocmd/let]
" [set]
" [map]
" [function] - fold if possible


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Initial setup                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ Initial setup


" directory
let g:vim_directory = '~/.config/nvim'
set nocompatible                       " resets several options to their defaults
autocmd!


if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | nested source $MYVIMRC 
endif


"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Plugin setup                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ Setup plugins


"{{{ Plugin settings

"{{{ Personal
"{{{ Number Toggle 
nmap <silent><leader>c :SCROLLCOLOR<cr>
nmap <leader>n :call NumberToggle()<cr>
"}}}
"}}}

"{{{ Rainbow
" Use a particular color scheme
let g:rainbow_active = 1
"}}}

"{{{ Gundo
let g:gundo_right=1
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
"}}}

"{{{ VimWiki
function! LoadVimWiki(info)
    nmap <Leader>wp :call vimwiki#base#goto_index(v:count, 3)<cr>
endfunction
"}}}

"{{{ Deoplete
let g:deoplete#enable_at_startup = 1
" let g:deoplete#keyword_patterns = {}
" let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'

let g:deoplete#omni#functions = get(g:, 'deoplete#omni#functions', {})
let g:deoplete#omni#functions.css = 'csscomplete#CompleteCSS'
let g:deoplete#omni#functions.html = 'htmlcomplete#CompleteTags'
let g:deoplete#omni#functions.markdown = 'htmlcomplete#CompleteTags'
" let g:deoplete#omni#functions.javascript =
"	\ [ 'tern#Complete', 'jspc#omni', 'javascriptcomplete#CompleteJS' ]

let g:deoplete#omni_patterns = get(g:, 'deoplete#omni_patterns', {})
let g:deoplete#omni_patterns.html = '<[^>]*'
" let g:deoplete#omni_patterns.javascript = '[^. *\t]\.\w*'
" let g:deoplete#omni_patterns.javascript = '[^. \t]\.\%\(\h\w*\)\?'
let g:deoplete#omni_patterns.php =
	\ '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

let g:deoplete#omni#input_patterns = get(g:, 'deoplete#omni#input_patterns', {})
let g:deoplete#omni#input_patterns.xml = '<[^>]*'
let g:deoplete#omni#input_patterns.md = '<[^>]*'
let g:deoplete#omni#input_patterns.css  = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni#input_patterns.scss = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni#input_patterns.sass = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni#input_patterns.python = ''
let g:deoplete#omni#input_patterns.javascript = ''
"}}}

"{{{ Pymode

function! LoadPymode()
    let g:pymode = 1 " Activate pymode
    let g:pymode_python = 'python'
    " ignore error code for unnecessary parenthesis
    " ignore import errors
    " let g:pymode_lint_ignore = "C0325, F0401"
    " use these error checkers
    " let g:pymode_lint_checkers = ['mccabe', 'pep8', 'pyflakes', 'pylint']
    let g:pymode_lint_on_write = 0
    let g:pymode_lint_cwindow = 0
    let g:pymode_lint_sort = ['E']
    let g:pymode_rope_completion = 0
    let g:pymode_rope_autoimport=0
    let g:pymode_run_bind = '<f5>'
    " let g:pymode_syntax = 1
    " let g:pymode_syntax_all = 0
    " let g:pymode_syntax_print_as_function = 0
    " let g:pymode_syntax_highlight_equal_operator = 0
    " let g:pymode_syntax_highlight_stars_operator = 0
    " let g:pymode_syntax_highlight_self = 1
    " let g:pymode_syntax_indent_errors = 0
    " let g:pymode_syntax_space_errors = 0
    " let g:pymode_syntax_string_formatting = 0
    " let g:pymode_syntax_string_format = 0
    " let g:pymode_syntax_string_templates = 0
    " let g:pymode_syntax_builtin_objs = 0
    " let g:pymode_syntax_builtin_types = 0
    " let g:pymode_syntax_highlight_exceptions = 0
    " let g:pymode_syntax_doctests = 1
    " let g:pymode_syntax_docstrings = 1
    nmap <f7> :PymodeLint<cr>
    nmap <leader><f7> :PymodeLintAuto<cr>
    nmap <f8> :vert lopen<cr>
endfunction
"}}}

"{{{ Deoplete + Neosnippet
" deoplete + neosnippet
let g:AutoPairsMapCR=0 
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1
let g:deoplete#auto_complete_start_length = 1 
let g:deoplete#enable_smart_case = 1
let g:neosnippet#snippets_directory = [ g:vim_directory."/bundle",
            \g:vim_directory."/bundle/neosnippet-snippets/neosnippets",
            \g:vim_directory."/bundle/vim-snippets/snippets" ] 
imap <expr><TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<c-t>") 
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<c-d>"
imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"
"}}}

"}}}

"{{{ Runtime

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  General                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(g:vim_directory.'/bundle')


" Personal plugins
Plug g:vim_directory.'/bundle/personal'
" Tree navigation of 'undo'
Plug 'sjl/gundo.vim'
" Color scheme
Plug 'sjl/badwolf'
" Show indent levels
" Might be slow. If that's the case, then let g:indentLine_faster = 1
Plug 'Yggdroot/indentLine'
" Advanced status line
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Easy character alignment
Plug 'godlygeek/tabular'
" Quick posting to Gist
Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
" Quickly add or change the surroundings
Plug 'tpope/vim-surround'
" Automatically close surroundings
Plug 'jiangmiao/auto-pairs'
" Landmark based movement
Plug 'easymotion/vim-easymotion' | Plug 'tpope/vim-repeat'
" Notetaking
Plug 'danetrata/vimwiki', { 'do': 'LoadVimWiki' , 'branch': 'dev' }
" Asynchronous keyword completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } | Plug 'davidhalter/jedi-vim'
" Automated document generation
Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets'

" Completions and snippets
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'Shougo/neosnippet' | Plug 'Shougo/neosnippet-snippets' | Plug 'honza/vim-snippets'
Plug 'Shougo/context_filetype.vim'
" Plug 'SirVer/ultisnips'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Python                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Python client
Plug 'neovim/python-client'
Plug 'klen/python-mode', {'for' : 'python'}

" PHP
Plug 'swekaj/php-foldexpr.vim', {'for' : 'php'}

" CSS
Plug 'hail2u/vim-css3-syntax', {'for' : 'css'}
Plug 'othree/csscomplete.vim', {'for' : 'css'}
Plug 'cakebaker/scss-syntax.vim', {'for' : 'css'}
Plug 'ap/vim-css-color', {'for' : 'css'}

call plug#end()


"}}}

"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              General settings                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ General settings


"{{{ Look
" rename screen title
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")             
filetype plugin indent on              " load filetype-specific indent files
syntax enable                          " enable syntax processing
let g:tex_conceal = ''                 " Show all formatting characters

set gfn=Monospace\ 12                  " font
set showcmd                            " show command in bottom bar
set title                              " rename terminal
" set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L]\ (%p%%)\ 
"             \\ %{SyntasticStatuslineFlag()} " detailed command bar
set history=200                        " a longer command history
set wildmenu                           " visual autocomplete for command menu
" set lines=30 columns=85
" color {{{
if has("gui_running")
    colorscheme badwolf
    let g:airline_theme='badwolf'
else
    colorscheme badwolf
endif
"}}}
"}}}

"{{{ Feel (aka functions)
" explicit mapping of <leader> \  and <localleader> ,
let mapleader="\\"
let maplocalleader=","

set clipboard=unnamedplus              " Specific system clipboard
set splitright                         " Preference splitting to the right
set splitbelow                         " Preference splitting below
set autochdir                          " always change the current directory to match buffer
set autoread                           " Refresh file if changed
" set hidden                             " allows switching between files without needing to save
set backspace=indent,eol,start         " allow backspace over these 
set virtualedit=onemore                " allows cursor beyond last char
set scrolljump=7                       " automatically scroll n when the cursor hits the edge
set scrolloff=5                        " keep the cursor n lines from the edge
set formatoptions=1 lbr                " linewrapping
set number                             " show line numbers
set ttyfast                            " send more characters to redraw
set wrap                               " word wrap
set textwidth=0 wrapmargin=0           " Don't break up paste
set colorcolumn=80                     " column at 80 "
set showmatch                          " highlight matching {[()]}
set ruler                              " Show cursor position in the status bar
set laststatus=2                       " Always show the status line
set ttimeout                           " key code timing
set ttimeoutlen=50                     " key code timing
set timeout                            " key map timing
set timeoutlen=5000                    " key map timing
set undofile                           " persistent undo
set undodir=~/.vim/undo                " persistent undo

autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * checktime
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" copy into system clipboard = +
nmap <leader>y "+y
" don't overwrite register on paste
" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()
" move between tabs
nmap <f4> :tabn<cr>
nmap <s-f4> :tabp<cr>
" replace the current word with yank
nmap <leader>cc viwc<C-R>0<esc>
nmap <c-o> o<esc>
" Map Ctrl-BS and Ctrl-Del to delete the previous word in insert mode.
imap <C-BS> <C-W>
imap <C-del> <esc>lvedi
" save session
nnoremap <leader>s :mksession <CR>

"{{{ don't overwrite register on paste
" I haven't found how to hide this function (yet)
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

"}}}
"{{{ surround 
" makes adding parenthesis easy
nmap <leader>) csw)
vmap <leader>) <S-S>)
"}}}
"{{{ Spell check toggle
" turn spelling on/off
nnoremap <leader>= :call SpellToggle()<cr>
function! SpellToggle()
    if(&spell==1) " currently enabled, set to disabled
        echom "SPELL CHECK OFF. "
        set nospell
    else " currently disabled, set to enable
        echom "SPELL CHECK ON. Suggestions:z= next:]s" 
        setlocal spell spelllang=en_us
    endif
endfunc
"}}}
"{{{ Show registers to paste
" Show common registers to paste
nmap <leader>p :reg<cr>
            \:call GetRegister()<cr>
function! GetRegister()
    call inputsave()
    let b:register_value = input("enter the register to paste \n")
    call inputrestore()
    echo ''
    let cmd = "normal! \""
    let cmd .= b:register_value
    let cmd .= "p"
    exe cmd
endfunction
" select register to paste
" nmap <leader>p :redir! > /tmp/vim-register<cr>
"             \:silent reg<cr>
"             \:redir END<cr>
"             \:leftabove vsp /tmp/vim-register<cr>
"             \:view<cr>
"             \:vert resize 40<cr>
"             \<c-w>l
"             \:call GetRegister()<cr>
"}}}
"{{{ Check mappings
function! CheckMappings()
    :echo "\"q\""| map <c-q>
    :echo "\"w\""| map <c-w>
    :echo "\"e\""| map <c-e>
    :echo "\"r\""| map <c-r>
    :echo "\"t\""| map <c-t>
    :echo "\"y\""| map <c-y>
    :echo "\"u\""| map <c-u>
    :echo "\"i\""| map <c-i>
    :echo "\"o\""| map <c-o>
    :echo "\"p\""| map <c-p>
    :echo "\"a\""| map <c-a>
    :echo "\"s\""| map <c-s>
    :echo "\"d\""| map <c-d>
    :echo "\"f\""| map <c-f>
    :echo "\"g\""| map <c-g>
    :echo "\"h\""| map <c-h>
    :echo "\"j\""| map <c-j>
    :echo "\"k\""| map <c-k>
    :echo "\"l\""| map <c-l>
    :echo "\"z\""| map <c-z>
    :echo "\"x\""| map <c-x>
    :echo "\"c\""| map <c-c>
    :echo "\"v\""| map <c-v>
    :echo "\"b\""| map <c-b>
    :echo "\"n\""| map <c-n>
    :echo "\"m\""| map <c-m>
endfunction
"}}}

" neovim terminal
tnoremap <Esc> <C-\><C-n>
" visor style terminal buffer
let s:termbuf = 0
function! ToggleTerm()
    belowright 15 split
    try
        exe 'buffer' . s:termbuf
        startinsert
    catch
        terminal
        let s:termbuf=bufnr('%')
        tnoremap <buffer> <A-t>  <C-\><C-n>:close<cr>
    endtry
endfunction

com! ToggleTerm call ToggleTerm()
nnoremap <A-t> :ToggleTerm<cr>
"}}}


"{{{ Unsorted

"{{{ Benchmark vimrc
nnoremap <silent> <leader>dd :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>dp :exe ":profile pause"<cr>
nnoremap <silent> <leader>dc :exe ":profile continue"<cr>
nnoremap <silent> <leader>dq :exe ":profile pause"<cr>:noautocmd qall!<cr>
"}}}

"  spaces and tabs {{{

syntax on                                "  allows vim to highlight language syntax based on filetype
syntax sync minlines=256                 "  speed up syntax. The trade off is there might be some inaccuracies with highlighting
set synmaxcol=250                        "  fixes slow downs with really long lines
set shiftwidth=4                         "  indenting is 4 spaces
set tabstop=4                            "  number of visual spaces per TAB
set expandtab                            "  tabs are spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅ "  highlights whitespace

"tab
" for command mode
" for insert mode
nmap <s-tab> <<
nmap <tab> >>
vmap <S-Tab> <
vmap <Tab> >
" }}}

" searching {{{
set incsearch                          " search as characters are entered
set hlsearch                           " highlight matches
set ignorecase
set smartcase
set regexpengine=1                     " use earlier regex implementation. faster results
" turn off search highlight
noremap <leader>/ :nohlsearch<CR>
" }}}

" folding {{{
set foldenable                         " enable folding
set foldlevelstart=0                   " open most folds by default
" set foldmethod=indent                  " fold based on indent level
nmap <leader>f0 :set foldlevel=0<CR>>
nmap <leader>f1 :tet foldlevel=1<CR>>
nmap <leader>f2 :set foldlevel=2<CR>>
nmap <leader>f3 :set foldlevel=3<CR>>
nmap <leader>f4 :set foldlevel=4<CR>>
nmap <leader>f5 :set foldlevel=5<CR>>
nmap <leader>f6 :set foldlevel=6<CR>>
nmap <leader>f7 :set foldlevel=7<CR>>
nmap <leader>f8 :set foldlevel=8<CR>>
nmap <leader>f9 :set foldlevel=9<CR>>
"}}} 

"{{{ mouse
" set mouse
set mouse=a
" shift+mouse selects blocks
noremap <c-LeftMouse> <4-LeftMouse>
inoremap <c-LeftMouse> <4-LeftMouse>
onoremap <c-LeftMouse> <C-C><4-LeftMouse>
noremap <c-LeftDrag> <LeftDrag>
inoremap <c-LeftDrag> <LeftDrag>
onoremap <c-LeftDrag> <C-C><LeftDrag>
"}}}

" movement {{{
" move vertically by visual line
noremap j gj
noremap k gk
" move by line when given a movement
onoremap j j
onoremap k k
" move to beginning/end of line
" together with virtualedit=onemore, moves the cursor one more
noremap B ^
noremap E $
vnoremap E $h
noremap W $l
" $/^ doesn't do anything
" nnoremap $ <nop>
" nnoremap ^ <nop>
" highlight last inserted text
nnoremap gV '[v']
"moving line up/down
nmap <M-j> ddp 
nmap <M-k> ddkP 
nmap <M><down> ddp
nmap <M><up> ddkP
"join up
nmap <s-k> k<s-j>
"move between panes
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
" }}}

"{{{ Close completion help
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"}}}

"{{{ Focus
    set updatetime=1000

    autocmd CursorMoved * if LongEnough( "b:myTimer", 2, 5 ) | set number nocursorline norelativenumber colorcolumn= | endif
    autocmd CursorHold * :set cursorline relativenumber colorcolumn=80  "updatetime=2000
" Returns true if at least delay seconds have elapsed since the last time this function was called, based on the time
" contained in the variable "timer". The first time it is called, the variable is defined and the function returns
" true.
"
" True means not zero.
"
" For example, to execute something no more than once every two seconds using a variable named "b:myTimer", do this:
"
" if LongEnough( "b:myTimer", 2 )
"   <do the thing>
" endif
"
" The optional 3rd parameter is the number of times to suppress the operation within the specified time and then let it
" happen even though the required delay hasn't happened. For example:
"
" if LongEnough( "b:myTimer", 2, 5 )
"   <do the thing>
" endif
"
" Means to execute either every 2 seconds or every 5 calls, whichever happens first.
function! LongEnough( timer, delay, ... )
    let result = 0
    let suppressionCount = 0
    if ( exists( 'a:1' ) )
        let suppressionCount = a:1
    endif
    " This is the first time we're being called.
    if ( !exists( a:timer ) )
        let result = 1
    else
        let timeElapsed = localtime() - {a:timer}
        " If it's been a while...
        if ( timeElapsed >= a:delay )
            let result = 1
        elseif ( suppressionCount > 0 )
            let {a:timer}_callCount += 1
            " It hasn't been a while, but the number of times we have been called has hit the suppression limit, so we activate
            " anyway.
            if ( {a:timer}_callCount >= suppressionCount )
                let result = 1
            endif
        endif
    endif
    " Reset both the timer and the number of times we've been called since the last update.
    if ( result )
        let {a:timer} = localtime()
        let {a:timer}_callCount = 0
    endif
    return result
endfunction
"}}}


"{{{ Commenting
augroup commentleader
    " Implementation comments
    " au[tocmd] [group] {event} {patern} [nested] {cmd}
    " group = [aug[roup], ...] 
    "   examples: aug_new
    " event = [VimEnter, BufWritePre, FileType, BufEnter, ...]
    " FileTypePattern = [python, cpp, rst, ...]
    "
    " Commenting blocks of code.
    let b:comment_leader = '# '

    autocmd FileType c,cpp,java,scala,cs let b:comment_leader = '// '
    autocmd FileType conf,fstab,apache   let b:comment_leader = '# '
    autocmd FileType tex                 let b:comment_leader = '% '
    autocmd FileType mail                let b:comment_leader = '> '
    autocmd FileType vim                 let b:comment_leader = '" '
    autocmd FileType sh,ruby             let b:comment_leader = '# '
    autocmd FileType python              let b:comment_leader = '# '


    noremap <silent> <localleader>c
                \ :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')
                \ <CR>/<CR>:nohlsearch<CR>
    noremap <silent> <localleader>u
                \ :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')
                \ <CR>//e<CR>:nohlsearch<CR>

    " Aligns comments
    " "<C-R>" pastes the register while "=escape()" assigns the register a
    " value
    noremap <silent> <localleader><Tab> 
                \ :Tab /<C-R>=escape(b:comment_leader,'\/')<CR><CR>

augroup END
"}}}
" }}}

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Python                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ python

nmap == :set textwidth=72<CR>gqj:set textwidth=79<CR>
" autocmd FileType python nnoremap <buffer> <localleader><F5> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <localleader>2 :term python ./% <CR>
autocmd FileType python nnoremap <buffer> <localleader>3 :term python3 ./% <CR>

autocmd FileType python call LoadPymode()

"{{{ syntastic
autocmd FileType python set makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
autocmd FileType python set errorformat=%f:%l:\ %m
"}}}

autocmd FileType python set smartindent

autocmd FileType python noremap <silent> <localleader>>
            \ :<C-B>silent <C-E>s/^/<C-R>=escape('    >>> ', '\/')
            \ <CR>/<CR>:nohlsearch<CR>
autocmd FileType python noremap <silent> <localleader><
            \ :<C-B>silent <C-E>s/^\V<C-R>=escape('    >>> ', ' \/')
            \ <CR>//e<CR>:nohlsearch<CR>

" highlight character at 72
autocmd FileType python highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd FileType python match OverLength /\%<73v.\%>72v/
autocmd FileType python map <localleader>n O# Note:<cr>"""<cr>"""<esc>O
autocmd FileType python map <localleader>t O# TODO:<cr>"""<cr>"""<esc>O
"}}}

"{{{ reStructured Text
let $rst=g:vim_directory.'/bundle/personal/plugin/rst.vim'
"}}}

"{{{ markdown
augroup filetypedetect_md
    au!
    
    " Headings
    au FileType md nnoremap <leader>h1 ^yypv$r=o<cr><esc>
    au FileType md inoremap <leader>h1 <esc>^yypv$r=o<cr>

    au FileType md nnoremap <leader>h2 ^yypv$r-o 
                \<cr><cr><cr><cr><cr><cr><esc> kkkk
    au FileType md inoremap <leader>h2 <esc>^yypv$r-o
                \<cr><cr><cr><cr><cr><cr><esc>kkkki 
    au FileType md nnoremap <leader>h3 ^yypv$r+o
                \<cr><cr><cr><cr><cr><cr><esc>kkkk
    au FileType md inoremap <leader>h3 <esc>^yypv$r+o
                \<cr><cr><cr><cr><cr><cr><esc>kkkki

    au FileType md nnoremap <leader>h4 ^yypv$r~o
                \<cr><cr><cr><cr><cr><cr><esc>kkkk
    au FileType md inoremap <leader>h4 <esc>^yypv$r~o
                \<cr><cr><cr><cr><cr><cr><esc>kkkki

    au FileType md nnoremap <leader>h5 ^yypv$r*o
                \<cr><cr><cr><cr><cr><cr><esc>kkkk
    au FileType md inoremap <leader>h5 <esc>^yypv$r*o
                \<cr><cr><cr><cr><cr><cr><esc>kkkki



    """Make Link (ml)
    " Highlight a word or phrase and it creates a link and opens a split so
    " you can edit the url separately. Once you are done editing the link,
    " simply close that split.
    au FileType md vnoremap <leader>ml yi`<esc>gvvlli`_<esc>:vsplit
                \<cr><C-W>l:$<cr>o<cr>.. _<esc>pA: http://TODO<esc>vb
    """Make footnote (ml)
    au FileType md iabbrev mfn [#]_<esc>:vsplit<cr><C-W>l:$<cr>o<cr>.. [#] TODO
    au FileType md set spell
    "Create image
    au FileType md iabbrev iii .. image:: TODO.png
                \<cr>    :scale: 100<cr>:align: center<cr><esc>kkkeel
    "Create figure
    au FileType md iabbrev iif .. figure:: TODO.png
                \<cr>    :scale: 100<cr>:align: center
                \<cr>:alt: TODO<cr><cr><cr>Some brief description<esc>kkkeel

    "Create note
    au FileType md iabbrev nnn .. note:: 
    "Start or end bold text inline
    au FileType md inoremap <leader>bb **
    "Start or end italicized text inline
    au FileType md inoremap <leader>ii *
    "Start or end preformatted text inline
    au FileType md inoremap <leader>pf ``

    " Fold settings
    "au FileType md set foldmethod=marker
    
    " Admonitions
    au FileType md iabbrev adw .. warning::
    au FileType md iabbrev adn .. note::
augroup END
" }}} 

"{{{ c/c++
    autocmd FileType cpp set cindent      " - stricter rules for C programs
    autocmd FileType cpp map <localleader>n O//Note:
    autocmd FileType cpp map <localleader>a O//ATTENTION
    autocmd FileType cpp map <localleader>f O//FINISHED
"}}}



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Vimrc specfic                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ Vim


autocmd FileType vim map <localleader>i 100i <esc>40\|dw
autocmd FileType vim set formatoptions-=cro
autocmd FileType vim set foldmethod=marker foldlevel=0

set modelines=1

"edit vimrc and load vimrc bindings
map <leader><f9> :execute 'tabedit '.g:vim_directory.'/init.vim'<CR>
map <f9> :call SourceVimrc()<cr>
" insert fold
vmap <localleader>zf Vc<cr><esc>zf<cr>pkA 
"{{{ Reload vimrc
if ( !exists( "*SourceVimrc" ) )
    function SourceVimrc()
        execute 'source '.g:vim_directory.'/init.vim'
        echom "new vimrc loaded!"
    endfunction
endif
"}}}
"}}}
" tell vim to to structure this file differently
" vim:foldmethod=marker:foldlevel=0

