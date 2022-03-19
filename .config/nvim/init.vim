"dein Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
let s:toml = '$HOME/.config/nvim/dein.toml'
if dein#load_state('$HOME/.cache/dein')
  call dein#begin('$HOME/.cache/dein', [s:toml])

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

    call dein#add('Shougo/dein.vim')

    " Add or remove your plugins here:
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/deol.nvim')
    call dein#add('liuchengxu/vim-which-key')
    call dein#add('arcticicestudio/nord-vim')
    call dein#add('rakr/vim-one')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('artur-shaik/vim-javacomplete2')
    call dein#add('scrooloose/nerdtree')
    call dein#add('jistr/vim-nerdtree-tabs')
    call dein#add('gavocanov/vim-js-indent')
    call dein#add('pangloss/vim-javascript')
    call dein#add('mustache/vim-mustache-handlebars')
    call dein#add('posva/vim-vue')
    call dein#add('keith/swift.vim')
    call dein#add('tomlion/vim-solidity')
    call dein#add('vim-scripts/OmniCppComplete')
    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('cakebaker/scss-syntax.vim')
    call dein#add('octol/vim-cpp-enhanced-highlight')
    call dein#add('krisajenkins/vim-postgresql-syntax')
    call dein#add('purescript-contrib/purescript-vim')
    call dein#add('slashmili/alchemist.vim')
    call dein#add('racer-rust/vim-racer')
    call dein#add('sheerun/vim-polyglot')
    call dein#add('evanleck/vim-svelte')
    call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
    call dein#add('neovim/nvim-lspconfig')
    call dein#add('hrsh7th/nvim-compe')
    call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': 'bash install.sh',
    \ })
    call dein#add('junegunn/fzf')
    call dein#add('moll/vim-bbye')
    call dein#add('dart-lang/dart-vim-plugin')
    call dein#add('github/copilot.vim')

    " You can specify revision/branch/tag.
    call dein#add('Shougo/vimshell.vim')

    call dein#add('Shougo/defx.nvim')

    call dein#add('fatih/vim-go', {'build': ':GoUpdateBinaries'})

    call dein#end()
    call dein#save_state()
endif
"
" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

" let g:deoplete#enable_at_startup = 1

source $HOME/.config/nvim/config/general.vim
source $HOME/.config/nvim/config/plugins.vim
source $HOME/.config/nvim/config/keys.vim
source $HOME/.config/nvim/config/colors.vim

" lua << EOF
" require'lspconfig'.gopls.setup{}
" EOF
