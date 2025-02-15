version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=indent,eol,start
set cscopeprg=/usr/bin/cscope
set cscopetag
set cscopeverbose
set fileencodings=ucs-bom,utf-8,latin1
set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175,a:blinkon0
set helplang=en
set hlsearch
set mouse=a
set ruler
set termencoding=utf-8
set viminfo='20,\"50
" vim: set ft=vim :
"
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set nobackup

set history=100		" keep 100 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set expandtab   "set et
set tabstop=4
set sw=4
set ic
set scs
set nu
set wrap

"colors jellybeans
colors torte
":vs
"set foldmethod=marker

"set expandtab   "set et
"retab

set autoindent		" always set autoindenting on

set cursorline


" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
"  hi Comment term=bold ctermfg=cyan guifg=#80a0ff
"  0    0   Black
"  1    4   DarkBlue
"  2    2   DarkGreen
"  3    6   DarkCyan
"  4    1  	DarkRed
"  5   	5 	DarkMagenta
"  6   	3 	Brown, DarkYellow
"  7   	7 	LightGray, LightGrey, Gray, Grey
"  8   	0* 	DarkGray, DarkGrey
"  9   	4* 	Blue, LightBlue
"  10   2* 	Green, LightGreen
"  11   6* 	Cyan, LightCyan
"  12   1* 	Red, LightRed
"  13   5* 	Magenta, LightMagenta
"  14   3* 	Yellow, LightYellow
"  15   7* 	White
   hi Comment ctermfg=LightBlue		ctermbg=White		cterm=italic 
   hi CommentJcok ctermfg=DarkMagenta	ctermbg=Black		cterm=italic 
   hi CommentRemove ctermfg=DarkBlue ctermbg=DarkGray cterm=italic
   "hi LineNr  term=NONE
   "hi NonText ctermfg=White	    ctermbg=Black		term=BOLD 
   "hi Normal  ctermfg=White	    ctermbg=BLACK
   hi Search  ctermfg=DarkRed		ctermbg=White	cterm=italic
"   hi Visual  ctermfg=Yellow	ctermbg=Black		term=underline 
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 178 characters.
  autocmd FileType text setlocal textwidth=300

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

""<Anirban>
"" THIS MAPPING CAN BE REMOVED IF IT CAUSES ANY INCONVINIENCE
"nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
"nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
"nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
"nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
"nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
"nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
"nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>	
"nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
""set ttimeoutlen=100
""<\Anirban>

" SystemVerilog and Verilog Syntax
"so  ~/.vim/systemverilog.vim
"au BufNewFile,BufRead *.sv  set filetype=verilog
"so  ~/.vim/verilog_systemverilog.vim
au BufNewFile,BufRead *.h,*.v,*.sv,*.svh,*.vh  set filetype=verilog
set guifont=Monospace\ 14
"set nowrap
set noswapfile
set wildignore=*.swp,*.svn,*.pyc
set textwidth=300

" add short-key to insert date
nmap <F3> i<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><ESC>
imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
"
" PDD Syntax
au BufNewFile,BufRead  *.pdd,*.PDD set filetype=xml

" Copy from Zhihu
" Change font size quickly
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 30

function! AdjustFontSize(amount)
   if has("gui_gtk2") && has("gui_running")
     let fontname = substitute(&guifont, s:pattern, '\1', '')
     let cursize = substitute(&guifont, s:pattern, '\2', '')
     if (cursize < s:minfontsize) || (cursize > s:maxfontsize)
       let cursize = 10
     endif
       let newsize = cursize + a:amount
      if (a:amount > 1) 
        let newsize = a:amount
     endif
      if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
       let newfont = fontname . " " . newsize
       let &guifont = newfont
     endif
   else
     echoerr "You need to run the GTK2 version of Vim to use this function."
   endif
endfunction 

map <C-Up> :call AdjustFontSize(1) <CR>
map <C-Down> :call AdjustFontSize(-1) <CR>
map <C-Home> :call AdjustFontSize(10) <CR>

"set list
"set listchars=tab:>-

" For NERDT
map <F4> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

syntax   on
filetype on
filetype plugin on
filetype indent on



"add by chenggang li
"map <F5> :Vexplore<CR>
"map <F6> :q<CR>


map <F5> :NERDTreeMirror<CR> 
map <F5> :NERDTreeToggle<CR> 


let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_liststyle = 3


