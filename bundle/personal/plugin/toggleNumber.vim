function! NumberToggle()
    if(&relativenumber==1) " enabled return disabled
        set number
        set norelativenumber
    else " disabled return enabled
        set number
        set relativenumber
    endif
endfunc

