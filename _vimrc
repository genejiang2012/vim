"===============================================================================
"Description: The configuration files for Gvim
"Author:Gene Jiang
"Date: 2011.10.15
"Update: 2016.02.17
"Details
"   1. Vundle configuration
"   2. Color theme
"   3. General Setting
"   4. vim user interface
"   5. vim markdown settings
"   6. pandoc settings
"   7. code snippet settings
"   8. auto complete settings
"   9. General IDE settings
"   10. Javascript IDE settings
"===============================================================================

"===============================================================================
" Environment judgment
"===============================================================================
"Environment {
    
    " Basics {
        set nocompatible        " Must be first line
        set background=dark    " Assume a dark background
    " }

    "Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
    
    " Arrow Key Fix {
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }

" }

"===============================================================================
" General Settings
"===============================================================================

" General {
    set background=light         " Assume a dark background

    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background
        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    
    noremap <leader>bg :call ToggleBG()<CR>

    " if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    " endif
    
    filetype plugin on
    filetype plugin indent on   " Automatically detect file types.
    filetype on
    filetype indent on
    
    syntax enable               " Enable the syntax
    syntax on                   " Syntax highlighting 
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    set nocp                    "set the compatiable pattern
    set autowriteall            "save the file automatically
    set history=100             "Set how many lines of history VIM has to remeber
    set autoread                "set to autoread when a file is changed from the outside
    set wildmenu                "Turn on Wild Menu
    set nu!                     "display line number

    "Set backspace config
    "set backspace=eol,start,indent
    set whichwrap +=<,>,h,l

    set ignorecase              " Ignore the case when searching
    set smartcase
    
    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else                    " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    "set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

" }

" Formatting {
    set wrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set colorcolumn=81              " Show the color column
    set textwidth=80 
    set fo+=m
    
    " tablength exceptions
    autocmd FileType html setlocal shiftwidth=2 tabstop=2
    autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
" }

" Encoding {
    "set the encoding for file
    scriptencoding utf-8
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
    set fencs=utf8,gbk,gb2312,gb18030

    "set the messy code for menu
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "set the messy code for the prompt information
    "language messages zh_CN.utf-8
"}

" Key (re)Mappings {
    let mapleader = ","
    
    "insert mode shortcut
    inoremap <C-h> <Left>
    inoremap <C-j> <Down>
    inoremap <C-k> <Up>
    inoremap <C-l> <Right>
    inoremap <C-d> <DELETE>
"}

" Searching {
    set ignorecase              " Ignore the case when searching
    set smartcase
    
    set hlsearch                "Highlight the searchthings
    set incsearch               "incremental search
    set hlsearch                "highlighted search results
"}

"===============================================================================
"Vundle configuration
"===============================================================================
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('$VIM/vimfiles/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    "silent !mkdir -p ~/.vim/bundle
    "silent !git clone https://github.com/gmarik/vundle $VIM/vimfiles/bundle/vundle
    let iCanHazVundle=0
endif

set rtp+=$VIM/vimfiles/bundle/vundle
call vundle#rc('$VIM/vimfiles/bundle')
Bundle 'gmarik/vundle' 


"===============================================================================
"VIM UI
"===============================================================================
"VIM colorsheme {        
    "Get the colorscheme
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'vim-scripts/Tango2'
    Bundle 'tomasr/molokai'
	Bundle 'lifepillar/vim-solarized8'
        
    "operation system
    if has("win32") || has("win64")
        let g:isWin = 1
    else
        let g:isWin = 0
    endif

    " vi or vim
    if has("gui_running")
        let g:isGUI = 1
    else
        let g:isGUI = 0
    endif

    "colorscheme for solarized
    "let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"

    "colorscheme molokai
    let g:molokai_original = 1

    if g:isGUI
		"set background=light
		set background=dark
        colorscheme solarized
		"colorscheme solarized8_flat
        "colorscheme Tango2
        "colorscheme molokai
        "colorscheme phd
    else
		"set background=dark
        "colorscheme solarized
        "colorscheme molokai
        "colorscheme phd
    endif

    "Highlight the current line
    if (g:isGUI)
        set cursorline
        hi cursorline guibg=#333333
        hi CursorColumn guibg=#333333
    endif
    
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set guioptions-=T           " hide the tool bar
    "set guioptions-=m           " hide the menu bar
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    "set list                        " show the space ...···
    set listchars=space:.,tab:->,trail:.,extends:#,nbsp:. " Highlight problematic whitespace  
"}

"===============================================================================
"Project settings
"===============================================================================
" Plugin NerdTree {
    Bundle 'scrooloose/nerdtree'
    
    "Key:,nt; open the nerdtree windows and show on the left side
    
    nmap <leader>nt :NERDTree<CR>
    nmap <leader>nf :NERDTreeFind<CR>
    
    "Settings for the nerdtree
    let NERDTreeHighlightCursorline=1
    let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$']
    let g:netrw_home='~/bak'
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=0
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
    "close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
" }

" Plugin tagBar {
    "Navigate the tagBbar
    Bundle 'majutsushi/tagbar'
    
    "usr ,tb to oen the tagbar window
    nmap <leader>tb :TagbarToggle<CR>
    let g:tagbar_autofocus = 1
" }

" Plugin taglist {
    "Show the taglist
    Bundle 'vim-scripts/taglist.vim'
    
    "Key Mapping: use ,tl to open the taglist window and show on the right side    
    nmap <leader>tl :Tlist<CR><c-l>
    
    let Tlist_Show_One_File        = 1           " only show the tags of the open file
    let Tlist_Exit_OnlyWindow      = 1           " exit vim if only tags window
    let Tlist_Use_Right_Window     = 1           " show on right side
    let Tlist_File_Fold_Auto_Close = 0           " auto fold
    "let Tlist_Sort_Type = "name"                 " items in tags sorted by name
"}

" Ctags {
    set tags=./tags;/,~/.vimtags

    " Make tags placed in .git/tags file available in all levels of a repository
    let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
    if gitroot != ''
        let &tags = &tags . ',' . gitroot . '/.git/tags'
    endif
" }

" AutoCloseTag {
    " Make it so AutoCloseTag works for xml and xhtml files as well
    au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    nmap <Leader>ac <Plug>ToggleAutoCloseMappings
" }

" Plugin vim-airline {
    " Set configuration options for the statusline plugin vim-airline.
    " Use the powerline theme and optionally enable powerline symbols.
    " To use the symbols , , , , , , and .in the statusline
    " segments add the following to your .vimrc.before.local file:
    "   let g:airline_powerline_fonts=1
    " If the previous symbols do not render for you then install a
    " powerline enabled font.

    " See `:echo g:airline_theme_map` for some more choices
    " Default in terminal vim is 'dark'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    
    nnoremap <C-N> :bn<CR>
    nnoremap <C-P> :bp<CR>
    
    let g:airline_theme = 'luna'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1    
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#whitespace#symbol = '!' 

    let g:airline_powerline_fonts = 0  
    "set guifont=Consolas\ for\ Powerline\ FixedD:h11
    
    let g:Powerline_symbols="fancy"
    let g:airline_symbols = {}
    "let g:airline_left_sep = "\u2b80" 
    "let g:airline_left_alt_sep = "\u2b81"
    "let g:airline_right_sep = "\u2b82"
    "let g:airline_right_alt_sep = "\u2b83"
    "let g:airline_symbols.branch = "\u2b60"
    "let g:airline_symbols.readonly = "\u2b64"
    "let g:airline_symbols.linenr = "\u2b61"
    "let g:airline#extensions#tabline#left_sep = "\u2b80"
    "let g:airline#extensions#tabline#left_alt_sep = "\u2b81"
   
    if !exists('g:airline_powerline_fonts')
        " Use the default set of separators with a few customizations
        let g:airline_left_sep='|'  " Slightly fancier than '>'
        let g:airline_right_sep='|' " Slightly fancier than '<'
    endif
    
" }

"===============================================================================
"Doc Tools settings
"===============================================================================
" Plugin auto-save{
    Bundle 'vim-scripts/vim-auto-save'
    let g:auto_save = 1             " enable AutoSave on Vim startup
    let g:auto_save_no_updatetime = 1
    let g:auto_save_in_insert_mode = 0
"}

" Pandoc {
    function! ToHtml()
        exec 'w'
        exec "!pandoc  -s -S --self-contained -c pandoc.css % -o %<.html "
    endfunction

    function! ToPdf()
        exec 'w'
        exec "!pandoc  % -o %<.pdf --latex-engine=xelatex --template=pm-template.latex"
    endfunction

    function! ToTex()
        exec 'w'
        exec "!pandoc  -s -S --self-contained % -o %<.tex "
        exec "!pandoc  -s -S --self-contained % -o %<.docx "
    endfunction

    function! ToDocx()
        exec 'w'
        exec "!pandoc  -s -S --self-contained % -o %<.docx "
    endfunction
    
    "Key mappings
    :nmap <F6>ph :call ToHtml()
    :nmap <F6>pp :call ToPdf()
    :nmap <F6>pt :call ToTex()
    :nmap <F6>pd :call ToDocx()
"}

" Plugin markdown mode{
    "Vim script for text filtering and aligment
    "Plugin tabular{

        Bundle 'godlygeek/tabular'
    
        " ,bb to align the code with "="
        nmap <leader>bb :Tab /=<CR>
        " ,bn to customize the align
        nmap <leader>bn :Tab /
    "}

    "Markdown vim mode
    "Plugin vim-markdown{
        Plugin 'plasticboy/vim-markdown'

        "Disable Folding
        let g:vim_markdown_folding_disabled = 1

        "Enable TOC window auto-fit
        let g:vim_markdown_toc_autofit = 1

        "Syntax extensions
        "LaTeX math
        let g:vim_markdown_math = 1
    
        let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

        autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    "}
"}
"Plugin writings{
    Bundle 'reedes/vim-litecorrect'
    Bundle 'kana/vim-textobj-user'
    Bundle 'reedes/vim-textobj-sentence'
    Bundle 'reedes/vim-textobj-quote'
    Bundle 'reedes/vim-wordy'
    
    "Lightweight auto-correction for Vim
    "Text litecorrect {
        augroup litecorrect
            autocmd!
            autocmd FileType markdown,mkd call litecorrect#init()
            autocmd FileType textile call litecorrect#init()
        augroup END
    "}
    
    "Improving on Vim's native sentence text object and motion
    " TextObj Sentence {    
        augroup textobj_sentence
            autocmd!
            autocmd FileType markdown call textobj#sentence#init()
            autocmd FileType textile call textobj#sentence#init()
            autocmd FileType text call textobj#sentence#init()
        augroup END
    " }
    
    " TextObj Quote {
    
        augroup textobj_quote
            autocmd!
            autocmd FileType markdown call textobj#quote#init()
            autocmd FileType textile call textobj#quote#init()
            autocmd FileType text call textobj#quote#init({'educate': 0})
        augroup END
    " }  
    
" }

"vim plugin for graphviz
"plugin wmgraphviz{
    Plugin 'wannesm/wmgraphviz.vim'
    
    let g:WMGraphviz_output = "png"
    
    "compile the graphviz
    nnoremap <leader>ll :GraphvizCompile<CR>
    nnoremap <leader>lv :GraphvizShow<CR>
    nnoremap <leader>li ::GraphvizInteractive<CR>
"}

"===============================================================================
" GUI General Settings
"===============================================================================
"GUI Settings{
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        if LINUX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
        elseif OSX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
        elseif WINDOWS() && has("gui_running")
            set guifont=Microsoft_YaHei_Mono:h13,Menlo:h13,Consolas:h13,Courier_New:h13
        endif
"}

"===============================================================================
"Programmings settings
"===============================================================================
" Syntastic{
    Plugin 'scrooloose/syntastic'
    
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
" }

" UndoTree {
    Plugin 'mbbill/undotree'

    nnoremap <Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
" }

" ctrlp {
    Plugin 'kien/ctrlp.vim'
    
    let g:ctrlp_working_path_mode = 'ra'

    let g:ctrlp_map = '<leader>p'
    let g:ctrlp_cmd = 'CtrlP'
    map <leader>f :CtrlPMRU<CR>
    
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

    if executable('ag')
        let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
    elseif executable('ack-grep')
        let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
    elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
    " On Windows use "dir" as fallback command.
    elseif WINDOWS()
        let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
    else
        let s:ctrlp_fallback = 'find %s -type f'
    endif
    if exists("g:ctrlp_user_command")
        unlet g:ctrlp_user_command
    endif
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': s:ctrlp_fallback
    \ }

    "Plugin {
        " CtrlP extensions
        Plugin 'tacahiroy/ctrlp-funky'
        let g:ctrlp_extensions = ['funky']
        
        "funky
        nnoremap <Leader>fu :CtrlPFunky<Cr>
       
        " narrow the list down with a word under cursor
        nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
        let g:ctrlp_funky_syntax_highlight = 1
    "}
"}

" Fugitive { 
        Plugin 'tpope/vim-fugitive'
        
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <leader>gi :Git add -p %<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
"}

"Plugin snippet{
	Plugin 'MarcWeber/vim-addon-mw-utils'
	Plugin 'tomtom/tlib_vim'
	Plugin 'garbas/vim-snipmate'

    Bundle 'SirVer/ultisnips'
    Bundle 'honza/vim-snippets'

    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsSnippetDirectories=['UltiSnips']
    let g:UltiSnipsSnippetsDir = 'D:/Vim/vimfiles/bundle/vim-snippets'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
 

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
    let g:snips_author="Gene Jiang"
    let g:snips_email = "zhengrong.jiang@chiefclouds.com"
    
"}

" Plugin html, css and web api code snippets{
    Bundle 'mattn/emmet-vim'
    Bundle 'mattn/webapi-vim'
    
    "let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.snippets_custom.json')), "\n"))
"}

" autocomplete settings
" YouCompleteMe {
    " Bundle 'Valloric/YouCompleteMe'
    Bundle 'ervandew/supertab'
	Bundle 'davidhalter/jedi-vim'

	"Basic Settings, ctrl+x, ctr+o as the short key
    au FileType php setl ofu=phpcomplete#CompletePHP
    au FileType ruby,eruby setl ofu=rubycomplete#Complete
    au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
    au FileType c setl ofu=ccomplete#CompleteCpp
    au FileType css setl ofu=csscomplete#CompleteCSS
    
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    
    " make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'
    "modify the short-key for the c function, ALT+;
    nnoremap <leader>yl :YcmCompleter GoToDeclaration<CR>   
    nnoremap <leader>yf :YcmCompleter GoToDefinition<CR>
    nnoremap <leader>yg :YcmCompleter GoToDefinitionElseDeclaration<CR>
	
	"let g:ycm_python_binary_path = 'D:\Python27'
    let g:ycm_python_binary_path = 'python'
	let g:ycm_global_ycm_extra_conf = 'D:/Vim/vimfiles/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
    " Don't show the confirm information for the YCM
    let g:ycm_confirm_extra_conf=0
    "Open the tags completion based on tags
    let g:ycm_collect_identifiers_from_tags_files=1
    "complete the word in the comments 
    let g:ycm_collect_identifiers_from_comments_and_strings = 0
    "Activate the completion when input 2 character
    let g:ycm_min_num_of_chars_for_completion=2
    " Generate the cache completion
    let g:ycm_cache_omnifunc=0
    " Show the completion as the list format
    set completeopt-=preview
    " Open the sysnt complete
    let g:ycm_seed_identifiers_with_syntax=1
    "Completion when input the input
    let g:ycm_complete_in_comments = 1
    "Complete when input the string
    let g:ycm_complete_in_strings = 1
    "Don't activate the completion
    let g:ycm_filetype_blacklist = {
        \ 'tagbar' : 1,
        \ 'nerdtree' : 1,
        \}
    let g:ycm_server_keep_logfiles = 1
    let g:ycm_server_log_level = 'debug'
	let g:ycm_key_invoke_completion = '<c-z>'
"}

"Eclim{
	let g:EclimCompletionMethod = 'omnifunc'	
"}

"Rainbow {
    Bundle 'kien/rainbow_parentheses.vim'
    let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['black',       'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]
    let g:rbpt_max = 40
    let g:rbpt_loadcmd_toggle = 0
"}

"Show no useful whitespaces{
    Plugin 'chrisbra/vim-show-whitespace'
"}

"Easy Motion{
    "Effective Motion // + w/f/l
    Bundle 'Lokaltog/vim-easymotion'
    
    let g:EasyMotion_smartcase = 1
    
    "let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
    map <Leader><leader>h <Plug>(easymotion-linebackward)
    map <Leader><Leader>j <Plug>(easymotion-j)
    map <Leader><Leader>k <Plug>(easymotion-k)
    map <Leader><leader>l <Plug>(easymotion-lineforward)
    "repeat the last operation
    map <Leader><leader>. <Plug>(easymotion-repeat)
"}

"match the single characters{
    Bundle 'vim-scripts/matchit.zip'
"}


"comment the code {
    Bundle 'scrooloose/nerdcommenter'
    let NERDSpaceDelims = 1
"}

" Surround{
    Bundle 'tpope/vim-surround'
    "for repeat -> enhance surround.vim, . to repeat command
    Bundle 'tpope/vim-repeat'
"}

" delimteMate{}
    Bundle 'Raimondi/delimitMate'
    " for python docstring ", optimize the input method
    au FileType python let b:delimitMate_nesting_quotes = ['"']
"}


"===============================================================================
" Javascript IDE settings
"===============================================================================
"tern(javascript) for vim{
    Bundle 'ternjs/tern_for_vim'
"}

"===============================================================================
" Python IDE settings
"===============================================================================
" PyMode {
    Plugin 'klen/python-mode'
        
    " Disable if python support not present
    if !has('python') && !has('python3')
        let g:pymode = 0
    endif

    "let g:pymode_lint_checkers = ['pyflakes']
    let g:pymode_trim_whitespaces = 0
    let g:pymode_options = 0
    let g:pymode_rope = 0
    let g:pymode_folding = 0
        
" }


"===============================================================================
" PHP IDE settings
"===============================================================================
" PIV {
    Plugin 'spf13/PIV'
    
    let g:DisableAutoPHPFolding = 0
    let g:PIVAutoClose = 0
 
" }

"===============================================================================
" Java IDE settings
"===============================================================================
" Java {
	Plugin 'artur-shaik/vim-javacomplete2'
    
	autocmd FileType java setlocal omnifunc=javacomplete#Complete
	let g:SuperTabDefaultCompletionType="context" 
	let g:SuperTabRetainCompletionType=2
 
"}

"===============================================================================
" SQL Complete
"===============================================================================
"SQL {
    Plugin 'vim-scripts/SQLCompletPlugin'

"}

"===============================================================================
" Plugin for robot framework
"===============================================================================
"Robot framework{
    Plugin 'mfukar/robotframework-vim'
"}
