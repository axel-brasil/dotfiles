set termguicolors
syntax enable

set mouse=
set nostartofline
set incsearch
set number
set relativenumber
set showcmd
" Case sensitivity
set noignorecase
set smartcase
set nocursorcolumn
set cursorline
set autoindent smartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab

highlight NonText guifg=#2F2F2F

" Coc, use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction


" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Toggle nerdtree
nnoremap <C-t> :NERDTreeToggle<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

call plug#begin('~/.config/nvim/plugins')
    Plug 'stevearc/vim-arduino'
    Plug 'stevearc/dressing.nvim'
    Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sheerun/vim-polyglot'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'srcery-colors/srcery-vim'
call plug#end()

lua << EOF
require("ibl").setup { scope = { highlight = highlight } }
EOF

colorscheme srcery
hi Normal guibg=NONE ctermbg=NONE
