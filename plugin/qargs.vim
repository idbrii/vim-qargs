command! -nargs=0 -bang -bar Qargs call s:SetArgs(QuickfixFilenames(), <bang>1)

function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let bufnr = quickfix_item['bufnr']
    " Lines without files will appear as bufnr=0
    if bufnr > 0
      let buffer_numbers[bufnr] = bufname(bufnr)
    endif
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

function! s:SetArgs(args, jump_to_first)
  if len(a:args) > 0
    0,1000argdelete
    execute 'argadd '. a:args
    if a:jump_to_first
      argument
    endif
  endif
endf

" vim:set et sw=2 ts=4 tw=78:
