function! Rst()
    noremap <localleader>r :InstantRst
    noremap <localleader>cr :StopInstantRst
    " Headings
    nnoremap <localleader>1
                \ ^yypVr=o<cr><esc>
    inoremap <localleader>1
                \ <esc>^yypv$r=o<cr>

    nnoremap <localleader>2
                \ ^yypv$r-<esc>6o<esc>kkkk
    inoremap <localleader>2
                \ <esc>^yypv$r-o<cr><cr><cr><cr><cr><cr><esc>kkkki

    nnoremap <localleader>3
                \ ^yypv$r^<esc>6o<esc>kkkk
    inoremap <localleader>3
                \ <esc>^yypv$r+o<cr><cr><cr><cr><cr><cr><esc>kkkki

    nnoremap <localleader>4
                \ ^yypv$r~o<cr><cr><cr><cr><cr><cr><esc>kkkk
    inoremap <localleader>4
                \ <esc>^yypv$r~o<cr><cr><cr><cr><cr><cr><esc>kkkki

    nnoremap <localleader>5
                \ ^yypv$r*o<cr><cr><cr><cr><cr><cr><esc>kkkk
    inoremap <localleader>5
                \ <esc>^yypv$r*o<cr><cr><cr><cr><cr><cr><esc>kkkki
    nnoremap <localleader>l
                \ ^O<c-o>0--------------------<esc>:s/\s\+$//e<cr>

    """Make Link (ml)
    " Highlight a word or phrase and it creates a link and opens a split so
    " you can edit the url separately. Once you are done editing the link,
    " simply close that split.
    vnoremap <localleader>ml
                \ yi`<esc>gvvlli`_<esc>:vsplit<cr><C-W>l:$<cr>o<cr>.. _<esc>pA: http://TODO<esc>vb
    """Make footnote (ml)
    iabbrev mfn [#]_<esc>:vsplit<cr><C-W>l:$<cr>o<cr>.. [#] TODO
    set spell
    "Create image
    iabbrev iii .. image:: TODO.png
                \ <cr>    :scale: 100<cr>:align: center<cr><esc>kkkeel

    "Create figure
    "autocmd FileType rst iabbrev iif .. figure:: TODO.png<cr>    :scale: 100<cr>:align: center<cr>:alt: TODO<cr><cr><cr>Some brief description<esc>kkkeel

    "Create note
    iabbrev nnn .. note:: 
    "Start or end bold text inline
    inoremap <localleader>bb **
    "Start or end italicized text inline
    inoremap <localleader>ii *
    "Start or end preformatted text inline
    inoremap <localleader>pf ``
    "Horizontal line


    " Fold settings
    "autocmd FileType rst set foldmethod=marker

    " Admonitions
    iabbrev adw .. warning::
    iabbrev adn .. note::

endfunction

autocmd FileType rst call Rst()
