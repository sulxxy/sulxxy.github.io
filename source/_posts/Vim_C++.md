title: Vim之C++补全
date: 2014-07-31 15:45:12
categories: Technique
tags: [Vim]
---

本文转自：[vim c++补全](http://blog.163.com/023_dns/blog/static/1187273662012120114837432/),
十分感谢作者。


首先确定vim编辑.cc或者.cpp文件时当前自动补全函数，在命令模式下输入

    :set omnifunc?

如果得到的结果为：omnifunc=ccomplete#Complete，说明有必要进行以下的操作以实现针对c++的自动补全

1. 首先安装OmniCppComplete，参见：[OmniCppComplete - C/C++ omni-completion with ctags database : vim online](http://www.vim.org/scripts/script.php?script_id=1520)
	
	安装的过程很简单，与大多数vim插件一样，cd到~/.vim/目录解压所下载的文件即可
2. 在~/.vim/目录下创建tags子目录
3. 创建stdc++ 对应的tags：

	A>. 首先下载经高手修改定制的libstdc++头文件，可以到这里下载：[tags for std c++ (STL, streams, ...) - Modified libstdc++ headers for use with ctags : vim online](http://www.vim.org/scripts/script.php?script_id=2358), 并将其解压到~/.vim/tags

	B>. 运行以下命令

    	$ cd ~/.vim/tags
    	$ ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ cpp_src
    	$ mv tags cpp
4. 按照步骤3为其他库创建tags，我选择了openGL 与　FLTK，下面为openGL对应的命令, FLTK类似

    	ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ /usr/include/GL
		mv tags gl
5. 修改~/.vimrc文件
	在其中加入以下内容：

    	" configure tags - add additional tags here or comment out not-used ones
    	set tags+=~/.vim/tags/cpp
    	set tags+=~/.vim/tags/gl
    	set tags+=~/.vim/tags/fl
    	" build tags of your own project with CTRL+F12
    	map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
    	" OmniCppComplete
    	let OmniCpp_NamespaceSearch = 1
    	let OmniCpp_GlobalScopeSearch = 1
    	let OmniCpp_ShowAccess = 1
    	let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
    	let OmniCpp_MayCompleteDot = 1 " autocomplete after .
    	let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
    	let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
    	let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
    	" automatically open and close the popup menu / preview window
    	au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    	set completeopt=menuone,menu,longest,preview
	注：我自己的.vimrc与上文不太一样，因为我嫌CTRL与F12离得太远不好操作，将健映射改为:

    	nmap <silent> <leader>uc :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
	另外我的.vimrc文件里原来还有以下内容:

    	" mapping
	    inoremap <expr> <CR>   pumvisible()?"\<C-Y>":"\<CR>"
	    inoremap <expr> <C-J>  pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
	    inoremap <expr> <C-K>  pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
	    inoremap <expr> <C-U>  pumvisible()?"\<C-E>":"\<C-U>"
	    "上面的映射都是在插入模式下的映射，解释如下：
	    "- 如果下拉菜单弹出，回车映射为接受当前所选项目，否则，仍映射为回车；
	    "- 如果下拉菜单弹出，CTRL-J映射为在下拉菜单中向下翻页。否则映射为CTRL-X CTRL-O；
	    "- 如果下拉菜单弹出，CTRL-K映射为在下拉菜单中向上翻页，否则仍映射为CTRL-K；
	    "- 如果下拉菜单弹出，CTRL-U映射为CTRL-E，即停止补全，否则，仍映射为CTRL-U；
6. 检验
	用vim打开cpp文件，输入

		std::
	将得到std命名空间的所有标示符，按CTRL+N或者CTRL+P选择
	继续输入std::vector vi，然后输入

		vi.
	vim将自动提示其成员
