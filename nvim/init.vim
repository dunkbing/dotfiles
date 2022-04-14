" >> load plugins
call plug#begin(stdpath('data') . 'vimplug')
    " telescope
    Plug 'nvim-lua/plenary.nvim' " required for telescope to work
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'LinArcX/telescope-command-palette.nvim'
    Plug 'lewis6991/gitsigns.nvim'

    " copilot
    Plug 'github/copilot.vim'

    " key bindings
    Plug 'folke/which-key.nvim'

    " lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'hrsh7th/nvim-compe'

    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'

    " Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'akinsho/bufferline.nvim'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'jiangmiao/auto-pairs'

    " color schemes
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'tomasiser/vim-code-dark'

    Plug 'nikvdp/neomux'

    Plug 'tpope/vim-ragtag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'

    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'

    " comment
    Plug 'numToStr/Comment.nvim'
call plug#end()

colorscheme codedark

" basic settings
syntax on
set number
" set relativenumber
set ignorecase      " ignore case
set smartcase     " but don't ignore it, when search string contains uppercase letters
set nocompatible
set incsearch        " do incremental searching
" set visualbell
set expandtab
set tabstop=4
set ruler
set smartindent
set shiftwidth=4
set hlsearch
" set virtualedit=all
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent
set mouse=a  " mouse support

" Enable copying from vim to clipboard
if has('win32')
	set clipboard=unnamed  
else
	set clipboard=unnamedplus
endif

" set leader key to ,
let g:mapleader="\\"

" >> setup nerdcomment key bindings
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1

xnoremap <Leader>ci <cmd>call NERDComment('n', 'toggle')<CR>
nnoremap <Leader>ci <cmd>call NERDComment('n', 'toggle')<CR>

nnoremap <silent> <C-k> <cmd>Lspsaga hover_doc<CR>
nnoremap <silent> <K>   <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-p> <cmd>Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> <C-n> <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ga    <cmd>Lspsaga code_action<CR>
xnoremap <silent> ga    <cmd>Lspsaga range_code_action<CR>
nnoremap <silent> gs    <cmd>Lspsaga signature_help<CR>

lua <<EOF
require("nvimtree")
require("lsp")
require("treesitter")
require("statusline")
require("completion")
require("gitsigns-config")
require("_telescope")
require("mappings")
require("comment")
EOF

