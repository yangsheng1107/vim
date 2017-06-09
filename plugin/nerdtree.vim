" *********************************************
" NERD插件属性
" *********************************************
map <F2> :NERDTreeToggle<CR>
let NERDTreeWinPos="left"
let NERDTreeIgnore=['\.o$','\.pyc$', '\~$'] "ignore files in NERDTree
" autocmd vimenter * NERDTree

" open NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif