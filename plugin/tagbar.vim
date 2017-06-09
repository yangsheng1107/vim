" *********************************************
" TagBar插件属性
" *********************************************
nmap <F3> :TagbarToggle<CR>

let g:tagbar_width=26
let g:tagbar_auto_faocus =1 
" 启动指定文件时自动开启tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

let g:tagbar_right=1
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_iconchars = ['+', '-']
"let g:tagbar_autoclose = 1

" c
let g:tagbar_type_c = {
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'd:macros:1',
        \ 'e:enumerators:1',
        \ 'f:functions',
        \ 'm:members:1',
        \ 'g:enums:1',
        \ 'v:variables:1',
        \ 't:typedefs:1',
        \ 's:structs:1',
        \ 'n:namespaces:1',
        \ 'u:unions:1',
        \ 'p:prototypes:1',
        \ 'x:external:1'
    \ ]
\}
" cpp
let g:tagbar_type_cpp = {
    \ 'kinds'     : [
        \ 'c: classes',
        \ 'd:macros:1',
        \ 'e:enumerators:1',
        \ 'f:functions',
        \ 'l:local:1',
        \ 'm:members:1',
        \ 'g:enums:1',
        \ 'v:variables:1',
        \ 't:typedefs:1',
        \ 's:structs:1',
        \ 'n:namespaces:1',
        \ 'u:unions:1',
        \ 'p:prototypes:1',
        \ 'x:external:1'
    \ ]
\}
