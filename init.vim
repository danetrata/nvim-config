" File: init.vim

" Author: Daniel Etrata
" Description:
" We will only try to load filetype specific plugins accordingly.
" To navigate the folds,  {up:'zk', down:'zj',
" open all one fold level:'zr', close all one fold level:'zm',
" toggle fold level:'za'}
" insert a fold:',zf'
" Last Modified: December 20, 2016
" General Guidelines:
" We will try to follow this organization for sections.
" [let]
" [set]
" [mappings]
" [functions] - fold if possible
" [autocmd] - fold if possible


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Initial setup                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ Initial setup


" directory
let g:vim_directory = '~/.config/nvim'
set nocompatible                       " resets several options to their defaults
set hidden
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
" overwrite theme colorcolumn. we use this in highlighting characters at col 81
autocmd VimEnter * highlight ColorColumn ctermbg=magenta
autocmd BufEnter * highlight ColorColumn ctermbg=magenta

"{{{ Plugin settings

"{{{ Personal
"{{{ Number Toggle
nnoremap <silent><leader>c :SCROLLCOLOR<cr>
nnoremap <leader>n :call NumberToggle()<cr>
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
let g:gundo_auto_preview = 0
let g:gundo_return_on_revert = 0
" let g:gundo_prefer_python3 = 1
"}}}

"{{{ VimWiki
function! LoadVimWiki(info)
    nnoremap <Leader>wp :call vimwiki#base#goto_index(v:count, 3)<cr>
endfunction
command! LoadVimWiki :call LoadVimWiki({'none': 'none'})
"}}}

"{{{ Deoplete
" let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 500
"}}}

"{{{ Pymode
let g:pymode = 1 " Activate pymode
let g:pymode_python = 'python'
let g:pymode_options = 1
let g:pymode_options_max_line_length = 80
let g:pymode_options_colorcolumn = 0
" ignore error code for unnecessary parenthesis
" ignore import errors
" let g:pymode_lint_ignore = "C0325, F0401"
let g:pymode_lint_ignore = 'E501, C0301, C0411'
" use these error checkers
let g:pymode_lint_checkers = ['mccabe', 'pep8', 'pyflakes', 'pylint']
let g:pymode_rope_rename_bind = '<leader>r'
let g:pymode_run_bind = ''
let g:pymode_lint_on_write = 0
let g:pymode_lint_cwindow = 0
let g:pymode_lint_sort = ['E']
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_completion = 1
let g:pymode_rope_autoimport = 1
let g:pymode_folding = 0
let g:pymode_syntax = 0
let g:pymode_doc = 0
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


python3 << EOF
import vim
import git
def is_git_repo():
    try:
        _ = git.Repo('.', search_parent_directories=True).git_dir
        return "1"
    except:
        return "0"
vim.command("let g:pymode_rope = " + is_git_repo())
EOF

function! LoadPymode(info)
    nnoremap <localleader>l :PymodeLint<cr>:vert lopen<cr><cr>
    nnoremap <LocalLeader>L :PymodeLintAuto<cr>
endfunction
command! LoadPymode :call LoadPymode({'none': 'none'})

" let b:location_open = 0
" function! LocationToggle()
"     if(b:location_open==1) " currently enabled, set to disabled
"         echom "Closing Python code checkers"
"         PymodeLintToggle
"         lclose
"         let b:location_open=0
"     else " currently disabled, set to enable
"         echom "Starting Python code checkers"
"         PymodeLintToggle
"         lopen
"         normal <cr>
"         let b:location_open=1
"     endif
" endfunc
" command! LocationToggle :call LocationToggle()
" FIXME: Fix toggle behavior. An example below.
" nnoremap <leader>q :call QuickfixToggle()<cr>
" 
" let g:quickfix_is_open = 0
" 
" function! QuickfixToggle()
"     if g:quickfix_is_open
"         cclose
"         let g:quickfix_is_open = 0
"         execute g:quickfix_return_to_window . "wincmd w"
"     else
"         let g:quickfix_return_to_window = winnr()
"         copen
"         let g:quickfix_is_open = 1
"     endif
" endfunction

"}}}

"{{{ jedi
" let g:jedi#use_splits_not_buffers = 'bottom'
let g:jedi#popup_on_dot = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 0

let g:jedi#rename_visual = ''
let g:jedi#rename = ''
let g:jedi#usages_command = '<leader>gu'
"}}}

"{{{ Deoplete + Neosnippet
" deoplete + neosnippet
" let g:AutoPairsMapCR=0
let g:AutoClosePreserveEnterMapping = 1
let g:deoplete#enable_at_startup = 1
let g:echo = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_smart_case = 1
let g:neosnippet#snippets_directory = [ g:vim_directory."/bundle",
            \ g:vim_directory."/bundle/neosnippet-snippets/neosnippets",
            \ g:vim_directory."/bundle/vim-snippets/snippets" ]
imap <expr><TAB> pumvisible() ?
            \ "\<C-n>" : 
                \ (neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : "\<c-t>") 
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<c-d>"
imap <expr><CR> pumvisible() ? 
            \ deoplete#close_popup() : 
                \ (neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>")
"                 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>\<Plug>AutoPairsReturn")
" imap <expr><CR> pumvisible() ? "<CR>" : "\<CR>\<Plug>AutoPairsReturn"
"}}}

"{{{ indentLine
let g:indentLine_maxLines = 500
let g:indentLine_faster = 1
"}}}

"{{{ Tag overview
let g:tagbar_show_linenumbers = -1
let g:tagbar_sort = 0
let g:tagbar_left = 1
nnoremap <leader>t :TagbarToggle<cr>
"}}}

"{{{ NERDTree
nnoremap `d :NERDTreeToggle<cr>
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeMapOpenInTab='<ENTER>'
"}}}

"{{{ airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#tabline#show_buffers = 0

" let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap g1 <Plug>AirlineSelectTab1
nmap g2 <Plug>AirlineSelectTab2
nmap g3 <Plug>AirlineSelectTab3
nmap g4 <Plug>AirlineSelectTab4
nmap g5 <Plug>AirlineSelectTab5
nmap g6 <Plug>AirlineSelectTab6
nmap g7 <Plug>AirlineSelectTab7
nmap g8 <Plug>AirlineSelectTab8
nmap g9 <Plug>AirlineSelectTab9
"}}} 

"{{{ tmux_navigator
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_no_mappings = 1

" nnoremap <silent> `h :TmuxNavigateLeft<cr>
" nnoremap <silent> `j :TmuxNavigateDown<cr>
" nnoremap <silent> `k :TmuxNavigateUp<cr>
" nnoremap <silent> `l :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
"}}}

"{{{ Simpylfold
    let g:SimpylFold_docstring_preview = 1
"}}}

"{{{ FastFold
"     let g:python_folding = 1
"}}}

"{{{ CommandT
" let g:CommandTAcceptSelectionMap = '<c-o>'
" let g:CommandTAcceptSelectionTabMap = '<cr>'
nnoremap <silent> <Leader>gt <Plug>(CommandT)
nnoremap <silent> <Leader>gb <Plug>(CommandTBuffer)
nnoremap <silent> <Leader>gj <Plug>(CommandTJump)
"}}}

"{{{ Ack
" ack with insensitive literal search.
" note the trailing whitespace
nnoremap <leader>a :Ack! -iF 
"}}}

" {{{ pgsql
let g:sql_type_default = 'pgsql'
" }}}

" {{{ pgsql
" vnoremap <leader>sf        <Plug>SQLU_Formatter<CR>
" }}}

"{{{ Ultisnip
" function! GetAllSnippets(info)
"   call UltiSnips#SnippetsInCurrentScope(1)
"   let list = []
"   for [key, info] in items(g:current_ulti_dict_info)
"     let parts = split(info.location, ':')
"     call add(list, {
"       \"key": key,
"       \"path": parts[0],
"       \"linenr": parts[1],
"       \"description": info.description,
"       \})
"   endfor
"   echo list
" endfunction
" command! GetSnippet :call GetAllSnippets({'none': 'none'})
"}}}

"{{{ Syntastic
let g:syntastic_shell = "/bin/bash"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }
"}}}

"{{{ PyDocString
nmap <silent> <localleader>d <Plug>(pydocstring)
"}}}

"{{{ easytags
let g:easytasgs_async = 1
"}}}

"{{{ atags
" autocmd BufWritePost * call atags#generate()
"}}}

"{{{ vim-autoformat
let g:formatterpath = ['~/github/yapf/yapf']
noremap <leader>f :Autoformat<cr>
"}}}

"{{{ splitjoin
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr> 
"}}}

"{{{
let g:bufferline_echo = 1
let g:bufferline_rotate = 2
"}}}
"}}}

"{{{ Runtime

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  General                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(g:vim_directory.'/bundle')


" Personal plugins
Plug g:vim_directory.'/bundle/personal'
" Better directory navigation
Plug 'scrooloose/nerdtree'
" Focused vim
Plug 'merlinrebrovic/focus.vim'
" Matching parenthesis
Plug 'luochen1990/rainbow'
" Tree navigation of 'undo'
Plug 'sjl/gundo.vim'
" Color scheme
Plug 'sjl/badwolf'
" Show indent levels
" Might be slow. If that's the case, then let g:indentLine_faster = 1
Plug 'Yggdroot/indentLine'
" Advanced status line
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Bottom bar buffer line
Plug 'bling/vim-bufferline'
" Easy character alignment
Plug 'godlygeek/tabular'
" Quick posting to Gist
Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
" Quickly add or change the surroundings
Plug 'tpope/vim-surround'
" Automatically close surroundings
" Plug 'somini/vim-autoclose'
Plug 'danetrata/vim-autoclose'
" Plug 'jiangmiao/auto-pairs'
" Landmark based movement
Plug 'easymotion/vim-easymotion' | Plug 'tpope/vim-repeat'
" Notetaking
Plug 'danetrata/vimwiki', {'branch': 'dev' }
autocmd! User vimwiki LoadVimWiki
" Asynchronous keyword completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } | Plug 'davidhalter/jedi-vim'
" Automated document generation
Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets'
" Grep
Plug 'vim-scripts/grep.vim'
" Large files
Plug 'vim-scripts/LargeFile'
" version control signs
Plug 'mhinz/vim-signify'
" file version control signs
Plug 'Xuyuanp/nerdtree-git-plugin'
" fuzzy file search
Plug 'wincent/Command-T'
" grep in vim
Plug 'mileszs/ack.vim'
" grep in vim
" Plug 'Numkil/ag.nvim'
" explore buffers
Plug 'jlanzarotta/bufexplorer'
" Narrowed windows
Plug 'chrisbra/NrrwRgn'
" Fuzzy search, tab and buffer management, and so much more
Plug 'vim-ctrlspace/vim-ctrlspace'

" faster folding, better than pymode
Plug 'Konfekt/FastFold'

" Tag generation
" Plug 'xolox/vim-easytags' | Plug 'xolox/vim-misc' | Plug 'xolox/vim-shell'
" Tag generation
" Plug 'fntlnz/atags.vim'
" Tag overview
Plug 'majutsushi/tagbar'
" join or split long lines
Plug 'AndrewRadev/splitjoin.vim'

" Tmux aware panes
Plug 'christoomey/vim-tmux-navigator'

" Completions and snippets
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim', { 'for': 'vim' }
" Plug 'Shougo/neosnippet' | Plug 'Shougo/neosnippet-snippets' | Plug 'honza/vim-snippets'
Plug 'Shougo/context_filetype.vim'
" Plug 'SirVer/ultisnips' | Plug 'Shougo/neosnippet-snippets' | Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate' | Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim'  | Plug 'Shougo/neosnippet-snippets' | Plug 'honza/vim-snippets'

" Syntax checker
Plug 'vim-syntastic/syntastic'

" Python client
" Completions and snippets
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" Neovim specific improvements
Plug 'neovim/python-client', {'for' : 'python'}
" Large library of python specific functions
Plug 'python-mode/python-mode', {'for' : 'python', 'branch' : 'master'}
autocmd! User python-mode LoadPymode
" Autodoc generation
Plug 'heavenshell/vim-pydocstring'
" Formatter
Plug 'Chiel92/vim-autoformat'

" Specific python folding
" Plug 'tmhedberg/SimpylFold'

" Django
Plug 'vim-scripts/django.vim', {'for' : ['python', 'html']}
Plug 'tweekmonster/django-plus.vim', {'for' : ['python', 'html']}

" Php
Plug 'swekaj/php-foldexpr.vim', {'for' : 'php'}

" Postgresql
Plug 'lifepillar/pgsql.vim'
Plug 'vim-scripts/SQLUtilities'

call plug#end()


"}}}

"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              General settings                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ General settings


"{{{ Look and Form
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
"  spaces and tabs {{{
syntax on                                "  allows vim to highlight language syntax based on filetype
syntax sync minlines=256                 "  speed up syntax. The trade off is there might be some inaccuracies with highlighting
set synmaxcol=400                        "  fixes slow downs with really long lines
set shiftwidth=4                         "  indenting is 4 spaces
set tabstop=4                            "  number of visual spaces per TAB
" placeholder for now
autocmd FileType yaml,yml set tabstop=2 shiftwidth=2
set expandtab                            "  tabs are spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅ "  highlights whitespace

"{{{ remove trailing whitespace on save
function! StripTrailingWhitespace()
  if search('\s\+$') > 0
    echom "Trailing whitespace found\n"
    normal mZ
    let l:chars = col("$")
    %s/\s\+$//ec
    if (line("'Z") != line(".")) || (l:chars != col("$"))
        echom "Trailing whitespace stripped\n"
    endif
    normal `Z
  endif
endfunction
command! StripTrailingWhitespace :call StripTrailingWhitespace()
"}}}
"{{{ Format text to appropriate width
function! FormatTextWidth()
    let l:cursor = synIDattr(synID(line("."),col("."),1),"name")
    if l:cursor =~ "comment" || l:cursor =~ "string"
    " formats string to max 72 col
        set textwidth=72
        normal gqj
        set textwidth=79
    else
        normal gqj
    end
endfunction

let s:syn_string = '\%(String\|Heredoc\|DoctestValue\|DocTest\|DocTest2\|BytesEscape\)$'
" Test if the line is a string.  Accepts a column number to test.  If no 
" column number is provided, test the first and last column of the line.
function! s:is_string(line, ...)
  return synIDattr(synID(a:line, a:0 ? a:1 : col([a:line, '$']) - 1, 1), 'name') =~? s:syn_string
        \ && (a:0 || synIDattr(synID(a:line, 1, 1), 'name') =~? s:syn_string)
endfunction
"}}}
command! FormatTextWidth :call FormatTextWidth()

" autocmd BufWritePre python,html,htmldjango,css,js call StripTrailingWhitespace()
nnoremap == :StripTrailingWhitespace<cr>:FormatTextWidth<cr>

"tab
" for command mode
" for insert mode
nnoremap <s-tab> <<
nnoremap <tab> >>
vmap <S-Tab> <
vmap <Tab> >
" }}}
"}}}
"{{{ Close completion help
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"}}}
"}}}

"{{{ Feel and Function
" explicit mapping of <leader> \  and <localleader> ,
let mapleader="\\"
let maplocalleader=","

set completeopt-=preview        " disable preview pane
set clipboard=unnamedplus       " Specific system clipboard
set splitright                  " Preference splitting to the right
set splitbelow                  " Preference splitting below
set autochdir                   " always change the current directory to match buffer
set autoread                    " Refresh file if changed

nnoremap <leader>ft :setlocal buftype=nofile bufhidden=hide noswapfile

" {{{ watchforchanges

" http://vim.wikia.com/wiki/Have_Vim_check_automatically_if_the_file_has_changed_externally

" If you are using a console version of Vim, or dealing
" with a file that changes externally (e.g. a web server log)
" then Vim does not always check to see if the file has been changed.
" The GUI version of Vim will check more often (for example on Focus change),
" and prompt you if you want to reload the file.
"
" There can be cases where you can be working away, and Vim does not
" realize the file has changed. This command will force Vim to check
" more often.
"
" Calling this command sets up autocommands that check to see if the
" current buffer has been modified outside of vim (using checktime)
" and, if it has, reload it for you.
"
" This check is done whenever any of the following events are triggered:
" * BufEnter
" * CursorMoved
" * CursorMovedI
" * CursorHold
" * CursorHoldI
"
" In other words, this check occurs whenever you enter a buffer, move the cursor,
" or just wait without doing anything for 'updatetime' milliseconds.
"
" Normally it will ask you if you want to load the file, even if you haven't made
" any changes in vim. This can get annoying, however, if you frequently need to reload
" the file, so if you would rather have it to reload the buffer *without*
" prompting you, add a bang (!) after the command (WatchForChanges!).
" This will set the autoread option for that buffer in addition to setting up the
" autocommands.
"
" If you want to turn *off* watching for the buffer, just call the command again while
" in the same buffer. Each time you call the command it will toggle between on and off.
"
" WatchForChanges sets autocommands that are triggered while in *any* buffer.
" If you want vim to only check for changes to that buffer while editing the buffer
" that is being watched, use WatchForChangesWhileInThisBuffer instead.
"
command! -bang WatchForChanges                  :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0})
command! -bang WatchForChangesWhileInThisBuffer :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0, 'while_in_this_buffer_only': 1})
command! -bang WatchForChangesAllFile           :call WatchForChanges('*', {'toggle': 1, 'autoread': <bang>0})
" WatchForChanges function
"
" This is used by the WatchForChanges* commands, but it can also be
" useful to call this from scripts. For example, if your script executes a
" long-running process, you can have your script run that long-running process
" in the background so that you can continue editing other files, redirects its
" output to a file, and open the file in another buffer that keeps reloading itself
" as more output from the long-running command becomes available.
"
" Arguments:
" * bufname: The name of the buffer/file to watch for changes.
"     Use '*' to watch all files.
" * options (optional): A Dict object with any of the following keys:
"   * autoread: If set to 1, causes autoread option to be turned on for the buffer in
"     addition to setting up the autocommands.
"   * toggle: If set to 1, causes this behavior to toggle between on and off.
"     Mostly useful for mappings and commands. In scripts, you probably want to
"     explicitly enable or disable it.
"   * disable: If set to 1, turns off this behavior (removes the autocommand group).
"   * while_in_this_buffer_only: If set to 0 (default), the events will be triggered no matter which
"     buffer you are editing. (Only the specified buffer will be checked for changes,
"     though, still.) If set to 1, the events will only be triggered while
"     editing the specified buffer.
"   * more_events: If set to 1 (the default), creates autocommands for the events
"     listed above. Set to 0 to not create autocommands for CursorMoved, CursorMovedI,
"     (Presumably, having too much going on for those events could slow things down,
"     since they are triggered so frequently...)
function! WatchForChanges(bufname, ...)
  " Figure out which options are in effect
  if a:bufname == '*'
    let id = 'WatchForChanges'.'AnyBuffer'
    " If you try to do checktime *, you'll get E93: More than one match for * is given
    let bufspec = ''
  else
    if bufnr(a:bufname) == -1
      echoerr "Buffer " . a:bufname . " doesn't exist"
      return
    end
    let id = 'WatchForChanges'.bufnr(a:bufname)
    let bufspec = a:bufname
  end
  if len(a:000) == 0
    let options = {}
  else
    if type(a:1) == type({})
      let options = a:1
    else
      echoerr "Argument must be a Dict"
    end
  end
  let autoread    = has_key(options, 'autoread')    ? options['autoread']    : 0
  let toggle      = has_key(options, 'toggle')      ? options['toggle']      : 0
  let disable     = has_key(options, 'disable')     ? options['disable']     : 0
  let more_events = has_key(options, 'more_events') ? options['more_events'] : 1
  let while_in_this_buffer_only = has_key(options, 'while_in_this_buffer_only') ? options['while_in_this_buffer_only'] : 0
  if while_in_this_buffer_only
    let event_bufspec = a:bufname
  else
    let event_bufspec = '*'
  end
  let reg_saved = @"
  "let autoread_saved = &autoread
  let msg = "\n"
  " Check to see if the autocommand already exists
  redir @"
    silent! exec 'au '.id
  redir END
  let l:defined = (@" !~ 'E216: No such group or event:')
  " If not yet defined...
  if !l:defined
    if l:autoread
      let msg = msg . 'Autoread enabled - '
      if a:bufname == '*'
        set autoread
      else
        setlocal autoread
      end
    end
    silent! exec 'augroup '.id
      if a:bufname != '*'
        "exec "au BufDelete    ".a:bufname . " :silent! au! ".id . " | silent! augroup! ".id
        "exec "au BufDelete    ".a:bufname . " :echomsg 'Removing autocommands for ".id."' | au! ".id . " | augroup! ".id
        exec "au BufDelete    ".a:bufname . " execute 'au! ".id."' | execute 'augroup! ".id."'"
      end
        exec "au BufEnter     ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHold   ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHoldI  ".event_bufspec . " :checktime ".bufspec
      " The following events might slow things down so we provide a way to disable them...
      " vim docs warn:
      "   Careful: Don't do anything that the user does
      "   not expect or that is slow.
      if more_events
        exec "au CursorMoved  ".event_bufspec . " :checktime ".bufspec
        exec "au CursorMovedI ".event_bufspec . " :checktime ".bufspec
      end
    augroup END
    let msg = msg . 'Now watching ' . bufspec . ' for external updates...'
  end
  " If they want to disable it, or it is defined and they want to toggle it,
  if l:disable || (l:toggle && l:defined)
    if l:autoread
      let msg = msg . 'Autoread disabled - '
      if a:bufname == '*'
        set noautoread
      else
        setlocal noautoread
      end
    end
    " Using an autogroup allows us to remove it easily with the following
    " command. If we do not use an autogroup, we cannot remove this
    " single :checktime command
    " augroup! checkforupdates
    silent! exec 'au! '.id
    silent! exec 'augroup! '.id
    let msg = msg . 'No longer watching ' . bufspec . ' for external updates.'
  elseif l:defined
    let msg = msg . 'Already watching ' . bufspec . ' for external updates'
  end
  echo msg
  let @"=reg_saved
endfunction
"}}}

"{{{ autoread
function! AutoRead()
    let autoreadargs={'autoread':1}
    execute WatchForChanges("*",autoreadargs)
endfunction
command! AutoRead :call AutoRead()
"}}}

set backspace=indent,eol,start  " allow backspace over these
set virtualedit=onemore         " allows cursor beyond last char
set scrolljump=7                " automatically scroll n when the cursor hits the edge
set scrolloff=5                 " keep the cursor n lines from the edge
" set formatoptions=1lbrq         " linewrapping
set formatoptions=1q         " linewrapping
set ttyfast                     " send more characters to redraw
set number                      " show line numbers
set wrap                        " word wrap
set textwidth=0 wrapmargin=0    " Don't break up paste
set showmatch                   " highlight matching {[()]}

" searching {{{
set incsearch                          " search as characters are entered
set hlsearch                           " highlight matches
set ignorecase
set smartcase
set regexpengine=1                     " use earlier regex implementation. faster results
" turn off search highlight
noremap <leader>/ :nohlsearch<CR>:call clearmatches()<cr>:IndentLinesEnable<cr>
" }}}

set ruler                       " Show cursor position in the status bar
set laststatus=2                " Always show the status line
set ttimeout                    " key code timing
set ttimeoutlen=50              " key code timing
set timeout                     " key map timing
set timeoutlen=5000             " key map timing
set undofile                    " persistent undo
set undodir=~/.vim/undo         " persistent undo
set shortmess=A                 " get rid of 'found swap file' warning, note ':recover to find swp files'

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

" max pane height
nnoremap g_ <c-w>_
" max pane width
nnoremap g\| <c-w><bar>
" max pane width and height
nnoremap gx <c-w>_<c-w><bar>
nnoremap gz <c-w>_<c-w><bar>
nnoremap <c-w>x <c-w>_<c-w><bar>
nnoremap <c-w>z <c-w>_<c-w><bar>
" all panes equal
nnoremap g= <c-w>=

" list buffers to go to
nnoremap <Leader>b :ls<CR>:b<Space>
" copy into system clipboard = +
nnoremap <leader>y "+y

" movement {{{
" move vertically by visual line
" noremap j gj
" noremap k gk
" move by line when given a movement
" onoremap j j
" onoremap k k
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
nnoremap <M-j> ddp 
nnoremap <M-k> ddkP 
nnoremap <M><down> ddp
nnoremap <M><up> ddkP
"join up
nnoremap <s-k> k<s-j>
"move between panes
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap gl <C-w>l
" gh overwrites select mode - this is fine - who uses select mode?
noremap gh <C-w>h
noremap gj <C-w>j
noremap gk <C-w>k
" currently using tmuxnavigator
" noremap `l <C-w>l
" noremap `h <C-w>h
" noremap `j <C-w>j
" noremap `k <C-w>k
" }}}
" move between tabs
nnoremap <f4> :tabn<cr>
nnoremap <s-f4> :tabp<cr>
nnoremap `n :tabn<cr>
nnoremap `N :tabp<cr>
" replace the current word with yank
nnoremap <leader>cc viwc<C-R>0<esc>
" Map Ctrl-BS and Ctrl-Del to delete the previous word in insert mode.
imap <C-BS> <C-W>
imap <C-del> <esc>lvedi
" save session
nnoremap <leader>s :mksession <CR>
" highlight text at col 81 and show indentlines
nnoremap <leader><bar> :call matchadd('ColorColumn', '\%81v', 100)<cr>:IndentLinesEnable<cr>

if exists("b:current_syntax")
  finish
endif

" Load Python syntax at the top level
runtime! syntax/python.vim
unlet b:current_syntax

" Load SQL syntax
syn include @SQL syntax/sql.vim

" Reference: https://github.com/krisajenkins/vim-java-sql/blob/master/after/syntax/java.vim
" Take care not to consume the double-quotes (\zs & \ze)
" Case-insensitive (no \C)
syn region SQLEmbedded start=+\z(['"]\)\zs[\s\n]*\v(ALTER|CALL|COMMENT|COMMIT|CONNECT|CREATE|DELETE|DROP|EXPLAIN|EXPORT|GRANT|IMPORT|INSERT|LOAD|LOCK|MERGE|REFRESH|RENAME|REPLACE|REVOKE|ROLLBACK|SELECT|SET|TRUNCATE|UNLOAD|UNSET|UPDATE|UPSERT)+ skip=+\\\z1+ end=+\ze\z1+ contains=@SQL containedin=pythonString

let b:current_syntax = "pysql"
"{{{ surround 
" makes adding parenthesis easy
let g:surround_40 = "(\r)"
let g:surround_91 = "[\r]"
let g:surround_123 = "{\r}"
"}}}
"{{{ Spell check toggle
" turn spelling on/off
nnoremap <leader>= :SpellToggle<cr>
function! SpellToggle()
    if(&spell==1) " currently enabled, set to disabled
        echom "SPELL CHECK OFF. "
        set nospell
    else " currently disabled, set to enable
        echom "SPELL CHECK ON. Suggestions:z= next:]s" 
        setlocal spell spelllang=en_us
    endif
endfunc
command! SpellToggle :call SpellToggle()
"}}}
"{{{ Show active buffers to jump
set switchbuf=usetab  " switch to the buffer before trying to open a split
" gm			Like "g0", but half a screenwidth to the right (or as
" 			much as possible).
nnoremap gb :GetBuffer<cr>
function! GetBuffer()
    exe "ls a"
    call inputsave()
    let b:buffer_value = input("enter the buffer to jump \n")
    call inputrestore()
    echo ''
    let cmd = "sbuffer "
    let cmd .= b:buffer_value
    exe cmd
endfunction
command! GetBuffer :call GetBuffer()
"}}}
"{{{ Show used marks to jump
nnoremap gm :GetMark<cr>
function! GetMark()
    exe "marks 0123456789"
    call inputsave()
    let b:mark_value = input("enter the mark to jump \n")
    call inputrestore()
    echo ''
    let cmd = "normal! `"
    let cmd .= b:mark_value
    exe cmd
endfunction
command! GetMark :call GetMark()
"}}}
"{{{ Show registers to paste
" Show common registers to paste
nnoremap <leader>p :GetRegister<cr>
function! GetRegister()
    exe "reg"
    call inputsave()
    let b:register_value = input("enter the register to paste \n")
    call inputrestore()
    echo ''
    let cmd = "normal! \""
    let cmd .= b:register_value
    let cmd .= "p"
    exe cmd
endfunction
command! GetRegister :call GetRegister()
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
command! CheckMappings :call CheckMappings()
"}}}
"{{{ Benchmark vimrc
" start a log file 'profile.log' and profile all functions used and files opened
nnoremap <silent> <leader>ll :exe ":profile start ~/profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>:echo "Starting logging"<cr>
nnoremap <silent> <leader>lp :exe ":profile pause"<cr>:echo "Paused logging"<cr>
nnoremap <silent> <leader>lc :exe ":profile continue"<cr>:echo "Continue logging"<cr>
nnoremap <silent> <leader>lq :exe ":profile stop"<cr>:echo "Quiting logging"<cr>
"}}}
" folding {{{
set foldenable                         " enable folding
set foldlevelstart=0                   " open most folds by default
" set foldmethod=indent                  " fold based on indent level
nnoremap z1 :set foldlevel=0<CR>
nnoremap z2 :set foldlevel=1<CR>
nnoremap z3 :set foldlevel=2<CR>
nnoremap z4 :set foldlevel=3<CR>
nnoremap z5 :set foldlevel=4<CR>
nnoremap z6 :set foldlevel=5<CR>
nnoremap z7 :set foldlevel=6<CR>
nnoremap z8 :set foldlevel=7<CR>
nnoremap z9 :set foldlevel=8<CR>
nnoremap z0 :set foldlevel=9<CR>
"}}} 

"{{{ neovim terminal
nnoremap <c-t> :ToggleTerm<cr>
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <leader>h <C-\><C-n><C-w>h
tnoremap <leader>j <C-\><C-n><C-w>j
tnoremap <leader>k <C-\><C-n><C-w>k
tnoremap <leader>l <C-\><C-n><C-w>l
" automatically enter terminal mode
autocmd BufWinEnter,WinEnter term://* startinsert

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
        tnoremap <buffer> <c-t>  <C-\><C-n>:close<cr>
    endtry
endfunction
command! ToggleTerm call ToggleTerm()
"}}}

"{{{ Focus
    set updatetime=3000

set cursorline cursorcolumn relativenumber
"     autocmd CursorMoved * :set number nocursorline nocursorcolumn norelativenumber colorcolumn=
"     autocmd CursorHold * if LongEnough( "b:myTimer", 5, 100 ) | set cursorline cursorcolumn relativenumber colorcolumn=80 | endif
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


function! CommentSection()
    let l:save = winsaveview()
    exec 's/^/'.b:comment_leader.'/'
    call winrestview(l:save)
endfunction
function! UncommentSection()
    exec 's/^'.b:comment_leader.'//e'
endfunction

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

    " default comment_leader
    let b:comment_leader = '# '

    autocmd FileType *                      let b:comment_leader = '# '
    autocmd FileType c,cpp,cs               let b:comment_leader = '// '
    autocmd FileType java,javascript,scala  let b:comment_leader = '// '
    autocmd FileType css                    let b:comment_leader = '// '
    autocmd FileType conf,fstab,apache,yaml let b:comment_leader = '# '
    autocmd FileType tex                    let b:comment_leader = '% '
    autocmd FileType mail                   let b:comment_leader = '> '
    autocmd FileType vim                    let b:comment_leader = '" '
    autocmd FileType sh,ruby                let b:comment_leader = '# '
    autocmd FileType python                 let b:comment_leader = '# '
    autocmd FileType sql,pgsql              let b:comment_leader = '-- '


    " "<C-R>" pastes the register while "=escape()" assigns the register a
    " value
    noremap <silent> <localleader>c
                \ :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')
                \ <CR>/<CR>:nohlsearch<CR>
    noremap <silent> <localleader>u
                \ :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')
                \ <CR>//e<CR>:nohlsearch<CR>



    autocmd FileType txt noremap <silent> <localleader>c
                \ :<C-B>silent <C-E>s/^\(.*\)$/<!-- \1 -->/
                \ <CR>:nohlsearch<CR>
    autocmd FileType txt noremap <silent> <localleader>u
                \ :<C-B>silent <C-E>s/^<!-- \(.*\) -->$/\1/e
                \ <CR>:nohlsearch<CR>

    " Aligns comments based on comment leader
    noremap <silent> <localleader><Tab> 
                \ :Tab /<C-R>=escape(b:comment_leader,'\/')<CR><CR>

augroup END
"}}}
function! EditMacro()
  call inputsave()
  let g:regToEdit = input('Register to edit: ')
  call inputrestore()
  execute "nnoremap <Plug>em :let @" . eval("g:regToEdit") . "='<C-R><C-R>" . eval("g:regToEdit")
endfunction
nmap <Leader>em :call EditMacro()<CR> <Plug>em
"}}}

"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Python                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ python

" " Adds 'self' keyword to highlight
" augroup python
"     autocmd!
"     autocmd FileType python
"                 \   syn keyword pythonSelf self
"                 \ | highlight def link pythonSelf Special
" augroup end


" autocmd FileType python nnoremap <buffer> <localleader><F5> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <localleader>2 :w<cr>:let g:current_file_name=expand('%:p')<cr>:tabedit<cr>:term python <c-r>=escape(g:current_file_name,'\/') <CR><cr>
autocmd FileType python nnoremap <buffer> <localleader>3 :w<cr>:let g:current_file_name=expand('%:p')<cr>:tabedit<cr>:term python3 <c-r>=escape(g:current_file_name,'\/') <CR><cr>
autocmd FileType sql,pgsql nnoremap <buffer> <localleader>r :w<cr>:let g:current_file_name=expand('%:p')<cr>:tabedit<cr>:term PAGER="less -S" psql lakeshore lakeshore_user -a -P null="<NULL>" -f <c-r>=escape(g:current_file_name,'\/') <CR><cr>
"-P format=wrapped 

" autocmd FileType python call LoadPymode()

"{{{ syntastic
autocmd FileType python set makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
autocmd FileType python set errorformat=%f:%l:\ %m
"}}}

autocmd FileType python set nosmartindent
autocmd FileType python set foldmethod=indent

autocmd FileType python noremap <silent> <localleader>>
            \ :<C-B>silent <C-E>s/^/<C-R>=escape('    >>> ', '\/')
            \ <CR>/<CR>:nohlsearch<CR>
autocmd FileType python noremap <silent> <localleader><
            \ :<C-B>silent <C-E>s/^\V<C-R>=escape('    >>> ', ' \/')
            \ <CR>//e<CR>:nohlsearch<CR>

" highlight character at 72
" autocmd FileType python highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" autocmd FileType python match OverLength /\%<73v.\%>72v/
autocmd FileType python map <localleader>n O# Note:<cr>"""<cr>"""<esc>O
autocmd FileType python map <localleader>t O# TODO:<cr>"""<cr>"""<esc>O
autocmd BufRead,BufNewFile *.html set filetype=htmldjango shiftwidth=2 tabstop=2
"}}}

"{{{ reStructured Text
" let $rst=g:vim_directory.'/bundle/personal/plugin/rst.vim'
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
nnoremap <leader><leader><leader><leader> :call SourceVimrc()<cr>
nnoremap <leader><leader><leader> :execute 'tabedit '.g:vim_directory.'/init.vim'<CR>
" insert fold
vmap <localleader>zf Vc<cr><esc>zf<cr>pkA 
"{{{ Reload vimrc
function! SourceVimrc()
    execute 'source '.g:vim_directory.'/init.vim'
    echom "new vimrc loaded!"
    execute 'syntax sync fromstart' 
endfunction
"}}}
"}}}
" tell vim to to structure this file differently
" vim:foldmethod=marker:foldlevel=0
