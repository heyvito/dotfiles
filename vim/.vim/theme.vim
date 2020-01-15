let s:base03 = [ '#808080', 8 ]
let s:base02 = [ '#000000', 0 ]
let s:base01 = [ '#00ff00', 10 ]
let s:base00 = [ '#ffff00', 11  ]
let s:base0 = [ '#0000ff', 12 ]
let s:base2 = [ '#c0c0c0', 7 ]
let s:base3 = [ '#ffffff', 15 ]
let s:yellow = [ '#808000', 3 ]
let s:red = [ '#800000', 1 ]
let s:magenta = [ '#800080', 5 ]
let s:white = [ '#ffffff', 255 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:white, s:base03 ], [ s:base03, s:base02 ] ]
let s:p.normal.right = [ [ s:white, s:base03 ], [ s:base03, s:base02 ] ]
let s:p.inactive.right = [ [ s:base02, s:base01 ], [ s:base00, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:base3, s:base03 ], [ s:base3, s:base03 ] ]
let s:p.replace.left = [ [ s:base3, s:red ], [ s:base3, s:base03 ] ]
let s:p.visual.left = [ [ s:base3, s:magenta ], [ s:base3, s:base03 ] ]
let s:p.normal.middle = [ [ s:base03, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base0, s:base02 ] ]
let s:p.normal.error = [ [ s:base2, s:red ] ]
let s:p.normal.warning = [ [ s:base02, s:yellow ] ]

let g:lightline#colorscheme#vito#palette = lightline#colorscheme#flatten(s:p)

let g:lightline = {
  \ 'colorscheme': 'vito',
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'enable': { 'tabline': 0 },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
  \  'active': {
  \    'left': [['mode', 'paste'], ['readonly',  'filename', 'modified']],
  \    'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \  }
  \}

function! g:BuffetSetCustomColors()
    hi! BuffetCurrentBuffer cterm=NONE ctermbg=8 ctermfg=255 guibg=#ffffff guifg=#000000
    hi! BuffetTab cterm=NONE ctermbg=0 ctermfg=8 guibg=#ffffff guifg=#000000
    hi! BuffetBuffer cterm=NONE ctermbg=0 ctermfg=8 guibg=#000000 guifg=#000000
endfunction

highlight Pmenu ctermbg=gray guibg=gray

let g:nord_cursor_line_number_background = 1
let g:nord_italic = 1
let g:nord_underline = 1

colorscheme nord
