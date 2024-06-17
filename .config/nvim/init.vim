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

" Custom command
command Reload source ~/.config/nvim/init.vim 

" Coc, use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

" Split focus 
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Toggle terminal on/off (neovim)
nnoremap <M-t> :call TermToggle(12)<CR>
inoremap <M-t> <Esc>:call TermToggle(12)<CR>
tnoremap <M-t> <C-\><C-n>:call TermToggle(12)<CR>

" Toggle nerdtree
nnoremap <C-t> :NERDTreeToggle<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

call plug#begin('~/.config/nvim/plugins')
    Plug 'stevearc/vim-arduino'
    Plug 'stevearc/dressing.nvim'
    Plug 'preservim/nerdtree'
    Plug 'sheerun/vim-polyglot'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'srcery-colors/srcery-vim'
    Plug 'RaafatTurki/corn.nvim'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
call plug#end()


lua << EOF
require("ibl").setup { scope = { highlight = highlight } }
require 'corn'.setup()

function gnome_theme_changer()
    local handle = io.popen("gdbus call --session --dest=org.freedesktop.portal.Desktop --object-path=/org/freedesktop/portal/desktop  --method=org.freedesktop.portal.Settings.Read org.freedesktop.appearance color-scheme")

    if string.match(handle:read('*a'), ' %d') == " 1" then
        vim.cmd("let airline_theme='badwolf'")
        vim.cmd("colorscheme srcery")
        vim.o.background = "dark"
        vim.cmd("highlight Normal guibg=none")
    else
        vim.cmd("let airline_theme='papercolor'")
        vim.cmd("colorscheme lunaperche")
        vim.o.background = "light"
        vim.cmd("highlight Normal guibg=none")
    end
        handle:close()
end
gnome_theme_changer()
EOF


" END OF FILE
