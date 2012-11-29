""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Not VI mode
 set nocompatible 

" Turn on specific actions for different types of files
 filetype indent plugin on 

" Enable highlighting for syntax
 syntax on

" redefine leader
 let mapleader = ","
 let maplocalleader = ","

" Show line number
 set nu

" Hightlight matching brackets
 set showmatch

" Ignore case sensitive when searching
 set ignorecase

" Hightlight searching results
 set hlsearch
 set incsearch

" tab width
 set tabstop=4
 set cindent shiftwidth=4
 set autoindent shiftwidth=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! EnsureVamIsOnDisk(vam_install_path)
  " windows users may want to use http://mawercer.de/~marc/vam/index.php
  " to fetch VAM, VAM-known-repositories and the listed plugins
  " without having to install curl, 7-zip and git tools first
  " -> BUG [4] (git-less installation)
  let is_installed_c = "isdirectory(a:vam_install_path.'/vim-addon-manager/autoload')"
  if eval(is_installed_c)
    return 1
  else
    if 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
      " I'm sorry having to add this reminder. Eventually it'll pay off.
      call confirm("Remind yourself that most plugins ship with ".
                  \"documentation (README*, doc/*.txt). It is your ".
                  \"first source of knowledge. If you can't find ".
                  \"the info you're looking for in reasonable ".
                  \"time ask maintainers to improve documentation")
      call mkdir(a:vam_install_path, 'p')
      execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
      " VAM runs helptags automatically when you install or update 
      " plugins
      exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
    endif
    return eval(is_installed_c)
  endif
endfun

fun! SetupVAM()
  " Set advanced options like this:
  " let g:vim_addon_manager = {}
  " let g:vim_addon_manager.key = value
  "     Pipe all output into a buffer which gets written to disk
  " let g:vim_addon_manager.log_to_buf =1

  " Example: drop git sources unless git is in PATH. Same plugins can
  " be installed from www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager.drop_git_sources = !executable('git')
  " let g:vim_addon_manager.debug_activation = 1

  " VAM install location:
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  if !EnsureVamIsOnDisk(vam_install_path)
    echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
    return
  endif
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " Tell VAM which plugins to fetch & load:
  call vam#ActivateAddons([
  	\ 'FuzzyFinder',
  	\ 'pathogen',
  	\ 'YankRing',
  	\ 'snipmate',
  	\ 'bufexplorer.zip',
  	\ 'The_NERD_tree',
  	\ 'Powerline',
  	\ 'ctrlp',
  	\ 'mru',
  	\ 'github:amix/open_file_under_cursor.vim',
  	\ 'peaksea',
  	\ 'github:altercation/vim-colors-solarized',
  	\ ], {'auto_install' : 0})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})

  " Addons are put into vam_install_path/plugin-name directory
  " unless those directories exist. Then they are activated.
  " Activating means adding addon dirs to rtp and do some additional
  " magic

  " How to find addon names?
  " - look up source from pool
  " - (<c-x><c-p> complete plugin names):
  " You can use name rewritings to point to sources:
  "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
  "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
  " Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Status line settings
  set laststatus=2
  set statusline=
  set statusline+=%<\			" cut at start
  set statusline+=%2*[%n%H%M%R%W]%*\	" buffer number, end flags
  set statusline+=%-40f\		" relative path
  set statusline+=%=			" separate between right- and left-aligned
  set statusline+=%1*%y%*%*\		" file type

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTERNAL PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" FuzzyFinder
  map <leader>ff :FufFile<CR>
  map <leader>fg :FufTaggedFile<CR>
  map <leader>ft :FufTag<CR>
  map <leader>fb :FufBuffer<CR>

" Snippets (SnipMate)
"   completes common code snippets after pressing tab
" NOTE:

