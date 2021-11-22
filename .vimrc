" switch appearance mode
se background=dark
" choose color scheme and highlight syntax
colo solarized|sy on
" use space as leader
let mapleader=" "
" write current file
nn <leader>w :w<cr>
" write buffer if modified then hide
nn <leader><leader> :x<cr>
" leave insert mode
ino jk <esc>|ino <c-c> <esc>
" reload .vimrc
nn <leader><cr> :so ~/.vimrc<cr>
" show and configure statusline
se ls=2 stl=%F\ %m%r%h%w%q%k%=%v\ %L
hi statusline ctermbg=none ctermfg=darkgrey
" set the character encoding
se enc=utf-8
" minimize update time for best experience
se updatetime=50
" highlight lenght limit
se colorcolumn=80
" strip trailing whitespaces
au bufwritepre *.py,*.sql,*.yaml %s/\s\+$//e
" set number of command-lines to remember
se history=555
" turn on wild menu
se wmnu
" redraw at the end of the macro
se lz
" map yanks to host clipboard
nn <leader>y "+y|vn <leader>y "+y|nn <leader>Y mzgg"+yG`z
" keep unnamed register content while paste or delete
vn <leader>p "_dP|nn <leader>d "_d|vn <leader>d "_d
" yank till the end of the line
nn Y y$
" run the current line as if it were a command
nn <silent> <leader>e :exe getline(line('.'))<cr>
" get help for the word under cursor
nn <leader>ghw :h <c-r>=expand("<cword>")<cr><cr>
" keep cursor in the middle while scrolling
let &so=777|nn <leader>zz :let &so=777+7-&so<cr><bar>:norm zz<cr>
" show line numbers and display relatively
se nu rnu
" toggle between absolute and relative line numbers
nn <silent> <c-n> :let [&nu,&rnu]=[&nu,&nu+&rnu==1]<cr>
" load without swapfile
se noswapfile
" no highlight search results
se nohls
" show where the pattern as it was typed
se is
" show command in the last line of the screen
se sc
" keep indentation when starting a new line
se ai
" use 4 spaces instead of tab
se ts=4 sts=4 sw=4 et
" no prompt warning when leaving modified buffer
se hid
" allow backspacing over everything in insert mode
se backspace=indent,eol,start
" use RU keys mapping and switch to EN by default
se kmp=russian-jcukenwin imi=0 ims=0
" toggle keymaps and unmap jk for ru
ino <c-l> <c-r>=L()<cr>
fu L()
  if &imi==0|cal feedkeys("\<c-^>")|exe 'try|iu jk|cat|endt' 
  el|cal feedkeys("\<c-^>")|exe 'ino jk <esc>'|en|retu ''
endf
" break undo sequence
ino <space> <c-g>u<space>|ino ) <c-g>u)|ino ( <c-g>u(
ino , <c-g>u,|ino . <c-g>u.|ino ! <c-g>u!|ino ? <c-g>u?
ino <cr> <c-g>u<cr>
" disable :ex
nn <silent> Q <nop>
" define strings to use in list mode
se lcs=space:·,tab:>·,trail:~,eol:¬
" enable automatic text wrapping
se fo+=t
" no wrap
se nowrap
" toggle wrap
nn ff :se wrap!<cr>
" comment current line with #
nn <leader>c 0i# <esc>
" insert date and day of the week
ino <c-d> <c-r>=toupper(strftime("%d/%m/%Y %a"))<cr>
" format paragraph
nn <leader>v mzgqip`z
" toggle visibility of list strings
nn <leader>l :se list!<cr>
" enable spellchecking and selector
se spl=en,ru|nn <leader>s :se spell!<cr>
" underline bad words
hi spellbad cterm=underline
" keep it centered 
nn n nzzzv|nn N Nzzzv|nn J mzJ`z
" open new windows below and to the right
se sb spr
" move around windows using control+hjkl
nn <c-h> <c-w>h|nn <c-j> <c-w>j|nn <c-k> <c-w>k|nn <c-l> <c-w>l
" open a database toolkit and issue a query to the db
nn <leader>db :vs ~/.db/.sql<cr>|nn <leader>qq :cal Q()<cr><cr>
fu Q()
  let fr=search(';$','bnW')+1|let to=search(';$','cnW')
  let f='~/.db/'.strftime('%Y%m%d%H%M%S').'.sql'
  let c=':'.fr.','.to.'w !psql '.$CONNINFO.'&>'.f|exe c
  exe 'ped '.f.'|winc j|res 16|se nowrap|winc k'
endf
" resize current window height
nn <leader>- :res -8<cr>|nn <leader>+ :res +8<cr>
" hide adjacent window
nm <leader>h <c-w>w<leader><leader>
" move selected rows
vn J :m '>+1<cr>gv=gv|vn K :m '<-2<cr>gv=gv
ino <c-j> <esc>:m .+1<cr>==|ino <c-k> <esc>:m .-2<cr>==
nn <leader>j <esc>:m .+1<cr>==|nn <leader>k <esc>:m .-2<cr>==
" mutate jumplist
nn <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nn <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
