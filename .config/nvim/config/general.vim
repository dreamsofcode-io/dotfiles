set ruler
if has('nvim')
  set termguicolors 
endif
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=2
set autoindent
set smartindent
set number
set background=dark
set splitbelow
set splitright
syntax on
syntax enable
set colorcolumn=80
set mouse=a
set cinoptions+=(shiftwidth

autocmd Filetype javascript match Error /\s\+$/
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=2 sts=2 sw=2
autocmd Filetype vue setlocal ts=2 sts=2 sw=2
autocmd Filetype cpp setlocal ts=4 sts=4 sw=4
autocmd Filetype java setlocal ts=4 sts=4 sw=4

hi clear
if exists("syntax_on")
  syntax reset
endif

set mouse=a

:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline!<CR>

autocmd Filetype dart setlocal cinoptions-=u2s
autocmd Filetype dart setlocal cinoptions-=(2s

function! SetupEnvironment()
  let l:path = expand('%:p')
  if l:path =~ '/home/elliott/Projects/SMSGorilla' || l:path =~ $GOPATH
    setlocal tabstop=4 shiftwidth=4 noexpandtab
    if &filetype == 'yaml'
      setlocal tabstop=2 shiftwidth=2
    else
      setlocal tabstop=4 shiftwidth=4
    endif
  endif

  if &filetype == 'go'
    setlocal tabstop=4 shiftwidth=4 noexpandtab
  endif
endfunction

autocmd! BufReadPost,BufNewFile * call SetupEnvironment()
