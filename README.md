My vimrc
    
这是我正式建立版本库的vim配置文件，以后就可以进行迭代更新、防止以往换机器导致的     
重新配置等等带来的问题。此版本使用vim-addons-manager进行vim插件管理，还没有配置     
完整，更新中ing！
[2012/11/30]        
继续增加了几个插件，下一步就是将打开文件列表栏和自动补充功能配置完成；

2013/03/25
使用方法：
1.首先安装git和ctags；
2.然后将此repo拷贝到本地$LOC_PATH；
3.建立两个软连接
    ln -s $LOC_PATH/vimrc  ~/.vimrc
    ln -s $LOC_PATH/vim_runtime ~/.vim_runtime
