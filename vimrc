" 檔案編碼
set encoding=utf-8
set fileencodings=utf-8,cp950


" 編輯喜好設定
syntax on        " 語法上色顯示
set nocompatible " VIM 不使用和 VI 相容的模式
set ai           " 自動縮排
set history=100  " 保留 100 個使用過的指令
set backspace=indent,eol,start  " 讓backspace可以刪除
set clipboard=unnamed " 共用剪貼簿

" 搜尋
set ic           " 設定搜尋忽略大小寫
set hlsearch     " 設定高亮度顯示搜尋結果
set incsearch    " 在關鍵字還沒完全輸入完畢前就顯示結果


" jk is escape
inoremap jk <esc>

" enable mouse {
    " set ttyfast
    " set ttymouse=xterm2
    " set mouse=a
" }

" ctrl key setting{
    " make sure add following code into ~/.bashrc
    " ==============================
    " bind -r '\C-s'
    " stty -ixon
    " ==============================

    inoremap <C-s> <esc>:w<cr>                 " save files
    nnoremap <C-s> :w<cr>
    inoremap <C-d> <esc>:wq!<cr>               " save and exit
    nnoremap <C-d> :wq!<cr>
    inoremap <C-q> <esc>:qa!<cr>               " quit discarding changes
    nnoremap <C-q> :qa!<cr>
"}

" display setting{
    set number       " 顯示行號。
    set ru           " 第幾行第幾個字
    set scrolloff=3  " 捲動時保留底下 3 行。
"}

" C/C++:
function! CSET()
    " display table, space
    "set listchars=tab:>-,space:.
    set listchars=tab:>-
    set list

    set cindent
    set textwidth=0
    set nowrap

    " snippet
    inoremap for for (;;)<cr>{<cr><cr>}<esc>3kf;i
    inoremap while while ()<cr>{<cr><cr>}<esc>3kf)i
    inoremap if if ()<cr>{<cr><cr>}<esc>3kf)i
    inoremap else<cr> else<cr>{<cr>}<esc>O
    inoremap else\ if else if ()<cr>{<cr><cr>}<esc>3kf)i
    inoremap #i #include
    inoremap printf printf("(%s)(%d)\r\n",__func__,__LINE__);<esc>2hi

endfunction

" MAKE:
function! MAKESET()
    " display table, space
    set listchars=tab:>-
    set list

    set textwidth=0
    set nowrap

    " in a Makefile we need to use <Tab> to actually produce tabs
    set noexpandtab
    set softtabstop=4
endfunction

" SetTitle:
function! GetFileExt(fname)
    return matchstr(a:fname, "[^.]*$")
endfunction

function! SetTitle()
    let f_ext = GetFileExt(expand("%"))

    if f_ext == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "\#############################################")
        call append(line(".")+1, "\# Copyright (c) 2017 AMIT Inc.,")
        call append(line(".")+2, "\# All rights not expressly granted are reserved.")
        call append(line(".")+3, "\# File        : ".expand("%"))
        call append(line(".")+4, "\# Author      : Shawn Yang")
        call append(line(".")+5, "\# Date        : ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+6, "\# Description :")
        call append(line(".")+7, "\#############################################")
        call append(line(".")+8, "")
    elseif f_ext == 'py'
        call setline(1,"#!/usr/bin/python")
        call append(line("."),"\# -*- coding: utf-8 -*-")
        call append(line(".")+1, "")
        call append(line(".")+2, "\#############################################")
        call append(line(".")+3, "\# Copyright (c) 2017 AMIT Inc.,")
        call append(line(".")+4, "\# All rights not expressly granted are reserved.")
        call append(line(".")+5, "\# File        : ".expand("%"))
        call append(line(".")+6, "\# Author      : Shawn Yang")
        call append(line(".")+7, "\# Date        : ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+8, "\# Description :")
        call append(line(".")+9, "\#############################################")
        call append(line(".")+10, "")
    elseif f_ext == 'h'
        let guardname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
        execute "normal! i#ifndef " . guardname
        execute "normal! o#define " . guardname
        execute "normal! 3o"
        execute "normal! Go#endif /* " . guardname . " */"
        normal! kk
    elseif (f_ext == 'c' || f_ext=='cpp')
        call setline(line("."),"/*********************************************")
        call append(line("."),   "* Copyright (c) 2017 AMIT Inc.,")
        call append(line(".")+1, "* All rights not expressly granted are reserved.")
        call append(line(".")+2, "* File        : ".expand("%"))
        call append(line(".")+3, "* Author      : Shawn Yang")
        call append(line(".")+4, "* Date        : ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+5, "* Description :")
        call append(line(".")+6,"********************************************/")
        call append(line(".")+7,"#include <stdio.h>")
        call append(line(".")+8,"#include <stdlib.h>")
        call append(line(".")+9,"#include <string.h>")
        call append(line(".")+10,"")
        call append(line(".")+11,"int main(int argc, char *argv[])")
        call append(line(".")+12,"{")
        call append(line(".")+13,"")
        call append(line(".")+14,"    return 0;")
        call append(line(".")+15,"}")
    endif
endfunction

" SetComment:
function! SetComment()
    if (&filetype == 'sh' || &filetype=='python')
        let b:comment_leader = '# '
    elseif (&filetype == 'c' || &filetype=='h' || &filetype=='cpp' || &filetype=='java')
        let b:comment_leader = '// '
    elseif &filetype == 'vim'
        let b:comment_leader = '" '
    else
        let b:comment_leader = ''
    endif
endfunction

" autocomplete setting{
    inoremap ( ()<LEFT>
    inoremap " ""<LEFT>
    inoremap ' ''<LEFT>
    inoremap [ []<LEFT>
    inoremap { {}<LEFT>
    inoremap < <><LEFT>

    filetype on
    filetype plugin on
    autocmd FileType c,cpp,h    exec ":call CSET()"
    autocmd FileType make       exec ":call MAKESET()"
    autocmd FileType *          exec ":call SetComment()"

    autocmd BufNewFile *.{c,cpp,cxx,cc,h},*.sh,*.py exec ":call SetTitle()"

"}

" tab setting{
    set expandtab        "replace <TAB> with spaces
    set softtabstop=4
    set shiftwidth=4
    set tabstop=4        " tab 的字元數
"}

" 設定 leader 為","
let mapleader = ","

" 透過 <leader>sv/ev 來載入/編輯 .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :edit $MYVIMRC<CR>

" 透過 <leader>eb 來編輯 .bashrc
nnoremap <leader>eb :edit ~/.bashrc<CR>

" 透過 <leader>cc/<leader>cd 來快速住解
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cd :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" status line {
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
set statusline+=\ \ \ [%{&ff}/%Y]
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

"}

source ~/.vim/bundle.vim
source ~/.vim/statusline.vim

if &diff
    set cursorline
    map ] ]c
    map [ [c
    map > dp
    map < do
endif

