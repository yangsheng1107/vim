
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
