" vim: foldlevelstart=0 foldmethod=marker
scriptencoding utf-8
let dracula_pro_path = '~/Documents/Dracula PRO — Zeno Rocha/themes/vim'
" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')
if isdirectory(dracula_pro_path)
    Plug dracula_pro_path
endif
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'dag/vim-fish'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'machakann/vim-highlightedyank'
Plug 'simnalamburt/vim-mundo'
Plug 'rakr/vim-one'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'altercation/vim-colors-solarized'
Plug 'ledger/vim-ledger'
Plug 'google/vim-maktaba'
Plug 'dhruvasagar/vim-table-mode'
Plug 'keith/swift.vim'
Plug 'bazelbuild/vim-ft-bzl'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'scrooloose/nerdtree'
Plug 'b4b4r07/vim-hcl'
Plug 'modille/groovy.vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'agreco/vim-citylights'
Plug 'jamessan/vim-gnupg'
" VueJS
Plug 'leafoftree/vim-vue-plugin'
" Typescript support
Plug 'HerringtonDarkholme/yats.vim'
Plug 'SirVer/ultisnips'
call plug#end()
" }}}
" General settings {{{
set number relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=0
set inccommand=split
set undofile
set undodir=$HOME/.local/tmp/vim-undo
set directory=$HOME/.local/tmp/vim-swap//
set wildignore+=*.pdf,*.o,*.obj,*.jpg,*.png,*.aux,*.run.xml,*.blg,*.bcf,*.bbl

" }}}
" Theme {{{
set background=dark
if isdirectory(dracula_pro_path)
    let g:dracula_colorterm = 0
    colorscheme dracula_pro
else
    colorscheme dracula
endif
let g:one_allow_italics=1
" let g:lightline = { 'colorscheme': 'challenger_deep'}
set termguicolors
function! ToggleBackground()
    if &background ==# "light"
        set background=dark
    else
        set background=light
    endif
endfunction
" }}}
" Keymappings {{{
let mapleader = '\'
let maplocalleader = ','
nnoremap <Leader>b :BuffergatorOpen<CR>
nnoremap <Leader>u :MundoToggle<CR>
nnoremap - ddp
nnoremap _ ddkP
inoremap <c-u> <esc>viwUA
nnoremap <c-u> viwU
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>jb :b#<cr>
nnoremap <leader>l :lclose<cr>
nnoremap <leader>q :cclose<cr>
nnoremap <leader>d :bdelete<cr>
nnoremap <leader>el :call execappend#execAndAppend()<cr>
nnoremap <leader>w :call ToggleBackground()<cr>
"nunmap <leader>t
nnoremap <leader>t :TableModeRealign<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
iabbrev @@ horst@zerokspot.com
inoremap jk <esc>
inoremap <esc> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <right> <nop>
inoremap <left> <nop>
nnoremap <leader>f :FZF<cr>
nnoremap <leader>n :ll<cr>
vnoremap <leader>c "+y
nnoremap <leader>gs :Gstatus<cr>
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
" }}}
" File types {{{
augroup restore_location
    autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup end
augroup custom_filetype_detection
    autocmd!
    autocmd BufNewFile,BufRead *sls set filetype=yaml
    autocmd BufNewFile,BufRead *.md.gpg set filetype=markdown
    autocmd BufNewFile,BufRead *.raml set filetype=yaml
    autocmd BufNewFile,BufRead *.yml.j2 set filetype=yaml
    autocmd BufNewFile,BufRead *.yaml.j2 set filetype=yaml
    autocmd BufNewFile,BufRead *ledger*dat set filetype=ledger
    autocmd BufNewFile,BufRead finances*dat set filetype=ledger
    autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile
    autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
    autocmd BufNewFile,BufRead docker-build.conf set filetype=json
    autocmd BufNewFile,BufRead squid.conf.j2 set filetype=squid
    autocmd BufNewFile,BufRead .envrc set filetype=sh
augroup end
" Ledger {{{
augroup custom_filetypes_ledger
    autocmd!
    autocmd FileType ledger set nowrap
augroup end
" }}}
" RST {{{
augroup custom_filetypes_rst
    autocmd!
    autocmd FileType rst let g:table_mode_corner_corner='+'
    autocmd Filetype rst let g:table_mode_header_fillchar='='
augroup end
" }}}
" YAML {{{
augroup custom_filetypes_yaml
    autocmd!
    autocmd Filetype yaml set shiftwidth=2
    autocmd Filetype yaml set tabstop=2
augroup end
" }}}
" Shell {{{
augroup custom_filetypes_sh
    autocmd!
    autocmd Filetype sh set shiftwidth=2
    autocmd Filetype sh set tabstop=2
augroup end
" }}}
" HCL {{{
augroup custom_filetypes_hcl
    autocmd!
    autocmd Filetype hcl set shiftwidth=2
augroup end
" }}}
" XML {{{
augroup custom_filestypes_xml
    autocmd!
    autocmd FileType xml set nowrap
augroup end
" }}}
" Markdown {{{
function! MarkdownPreview()
    let abspath = shellescape(expand("%:p"))
    call system("open -a \"Marked 2\" " . abspath)
endfunction
augroup custom_Filetypes_markdown
    autocmd!
    autocmd FileType markdown nnoremap <leader>p :call MarkdownPreview()<cr>
augroup end
" }}}
" Go {{{
augroup custom_filetypes_go
    autocmd!
    autocmd FileType go :set nowrap
augroup end
" }}}

" JavaScript {{{
augroup custom_filetypes_javascript
    autocmd!
    autocmd FileType javascript :set nowrap
augroup end
" }}}
" }}}
" Plugin settings {{{
" Go {{{
let g:go_debug = []
let g:go_fmt_command = "goimports"
let g:go_metalinter_enabled = ["vet"]
let g:go_metalinter_autosave_enabled = ["vet"]
let g:go_metalinter_disabled = ["maligned", "errcheck", "structcheck", "varcheck"]
let g:go_metalinter_deadline = "5s"
let g:go_list_height = 2
set completeopt-=preview
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
nnoremap <leader>jd :GoDef<cr>

" }}}
" Ack {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" }}}
" Deoplete {{{
"set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#use_cache = 1
" }}}
" Buffergator {{{
let g:buffergator_sort_regime = 'mru'
let g:buffergator_viewport_split_policy = 'T'
" }}}
" ALE {{{
" Keep the sign-column enabled all the time:
" https://xoxo.zone/@annika/646614
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_open_list = 0
let g:ale_linters = {'go': ['gometalinter.v2', 'go build']}
let g:ale_go_gometalinter_options = '--disable-all --enable=vet --enable=gotype --enable=golint'
" }}}
" Python {{{
if has('mac')
    let g:python_host_prog  = '/usr/local/bin/python2'
    let g:python3_host_prog = '/usr/local/opt/python@3.8/bin/python3'
endif
let g:ale_python_pylint_auto_pipenv = 1
" }}} 
" }}}
