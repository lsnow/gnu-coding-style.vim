" Vim plugin to fit the GNU coding style
" Maintainer:   lsnow <wuwoyi@gmail.com>
" License:      Distributed under the same terms as Vim itself.
"
" This script is inspired from an article written by Bart:
" http://www.jukie.net/bart/blog/vim-and-linux-coding-style,
" https://github.com/vivien/vim-linux-coding-style,
" https://www.sites.google.com/site/lvhuiwei/vim/vimrc/gnu-coding-style
" and various user comments.
"
" For those who want to apply these options conditionally, you can define an
" array of patterns in your vimrc and these options will be applied only if
" the buffer's path matches one of the pattern. In the following example,
" options will be applied only if "gnome/", "gtk", "glib", or "gdk" is in
" buffer's path.
"
"   let g:gnusty_patterns = [ "gnome", "glib", "GNOME" ]

if exists("g:loaded_gnusty")
    finish
endif
let g:loaded_gnusty = 1

augroup gnusty
    autocmd!

    autocmd FileType c,cpp call s:GnuConfigure()
augroup END

function s:GnuConfigure()
    let apply_style = 0

    if exists("g:gnusty_patterns")
        let path = expand('%:p')
        for p in g:gnusty_patterns
            if path =~ p
                let apply_style = 1
                break
            endif
        endfor
    endif

    if apply_style
        call s:GnuCodingStyle()
    endif
endfunction

command! GnuCodingStyle call s:GnuCodingStyle()

function! s:GnuCodingStyle()
    call s:GnuFormatting()
    call s:GnuKeywords()
    call s:GnuHighlighting()
endfunction

function s:GnuFormatting()
    setlocal shiftwidth=2
    setlocal tabstop=8
    setlocal softtabstop=1
    setlocal expandtab smarttab
    setlocal textwidth=80
    setlocal cindent
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
endfunction

function s:GnuKeywords()
    syn keyword cStatement fallthrough
    syn keyword cOperator g_autofree g_autoptr g_auto
    syn keyword cType gint8 guint8 gint16 guint16 gint guint gint32 guint32 gulong
    syn keyword cType gsize gpointer
endfunction

function s:GnuHighlighting()
    highlight default link GnuError ErrorMsg

    syn match GnuError / \+\ze\t/     " spaces before tab
    syn match GnuError /\%>80v[^()\{\}\[\]<>]\+/ " virtual column 81 and more

    " Highlight trailing whitespace, unless we're in insert mode and the
    " cursor's placed right after the whitespace. This prevents us from having
    " to put up with whitespace being highlighted in the middle of typing
    " something
    autocmd InsertEnter * match GnuError /\s\+\%#\@<!$/
    autocmd InsertLeave * match GnuError /\s\+$/
endfunction

" vim: ts=4 et sw=4
