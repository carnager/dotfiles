if !g:bling_no_map
  nnoremap <silent> n nzz:call BlingHighight()<CR>
  nnoremap <silent> N Nzz:call BlingHighight()<CR>
  nnoremap <silent> * *zz:call BlingHighight()<CR>
  nnoremap <silent> # #zz:call BlingHighight()<CR>

  if !g:bling_no_expr
    cnoremap <silent> <expr> <enter> BlingExpressionHighlight()
  endif
endif
