if has('syntax') && (&t_Co > 2)
  syntax on
endif

colorscheme lucius

set autoindent
set backspace=indent,eol,start
set cursorline cursorcolumn
set expandtab
set hidden "lets you hide buffers without having to save first
set history=50
set hlsearch
set incsearch
set laststatus=2
set list
set listchars=tab:»·,trail:·
set nomodeline
set ruler
set shiftround
set shiftwidth=2
set showcmd
set showmatch
set showmode
set smartcase
set smartindent
set t_Co=256 "to fix colors
set tabstop=2
set visualbell t_vb=
set wildmode=list:longest,full
set wrap

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Autoindent for python
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
