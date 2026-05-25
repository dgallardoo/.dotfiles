" ===== BASIC SETTINGS =====
set nocompatible               " Disable vi compatibility mode
set encoding=utf-8             " Set file encoding to UTF-8
set fileformat=unix            " Use Unix line endings
set mouse=a                    " Enable mouse support
set clipboard=unnamedplus      " Use system clipboard

" ===== VISUAL IMPROVEMENTS =====
syntax enable                  " Enable syntax highlighting
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set cursorline                 " Highlight current line
set showmatch                  " Highlight matching brackets


" ===== INDENTATION & FORMATTING =====
set autoindent                 " Auto-indent new lines
set smartindent                " Smart indentation for programming
set tabstop=2                  " Tab width = 2 spaces
set shiftwidth=2               " Indentation width = 2 spaces
set expandtab                  " Convert tabs to spaces
set smarttab                   " Smart tab behavior

" ===== SEARCH IMPROVEMENTS =====
set incsearch                  " Incremental search (search as you type)
set hlsearch                   " Highlight search matches
set ignorecase                 " Case-insensitive search
set smartcase                  " Case-sensitive if uppercase letters used

nnoremap <esc> :noh<return><esc> " Clear search highlights with Esc

" ===== EDITOR BEHAVIOR =====
set backspace=indent,eol,start " Allow backspace over everything
set wrap                       " Wrap long lines
set scrolloff=8                " Keep 8 lines visible above/below cursor
set sidescrolloff=8            " Keep 8 characters visible left/right

" ===== PERSISTENT UNDO =====
" Save undo history to file so it persists after closing Vim
if has('persistent_undo')
  set undodir=~/.vim/undodir
  set undofile
endif

" ===== FILE HANDLING =====
set autoread                   " Auto-reload files changed outside vim
set hidden                     " Allow switching buffers without saving

" ===== STATUS LINE =====
set laststatus=2               " Always show status line
set ruler                      " Show cursor position
set showcmd                    " Show partial commands

" ===== PERFORMANCE =====
set lazyredraw                 " Don't redraw during macros
set ttyfast                    " Fast terminal connection

" ===== WILDMENU (TAB COMPLETION) =====
set wildmenu                   " Enhanced command line completion
set wildmode=longest:full,full " Tab completion behavior
