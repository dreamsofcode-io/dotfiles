
" NERDTree \n to open up the tree
map <Leader>n <plug>NERDTreeTabsToggle<CR>
map <Leader>' :sp<CR>:10winc -<CR>:Deol<CR>
map <Leader>] :vsp<CR>:Deol<CR>

" deoplete tab-complete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <C-W>" :split<CR>
nnoremap <C-W>% :vsplit<CR>
nnoremap <leader>" :split<CR>
nnoremap <leader>% :vsplit<CR>
nnoremap <M-left> :vertical resize -5<cr>
nnoremap <M-down> :resize +5<cr>
nnoremap <M-up> :resize -5<cr>
nnoremap <M-right> :vertical resize +5<cr>

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

autocmd FileType java nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
autocmd FileType java imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
autocmd FileType java nmap <F5> <Plug>(JavaComplete-Imports-Add)
autocmd FileType java imap <F5> <Plug>(JavaComplete-Imports-Add)
autocmd FileType java nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
autocmd FileType java imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
autocmd FileType java nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
autocmd FileType java imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

tnoremap <ESC>   <C-\><C-n>
