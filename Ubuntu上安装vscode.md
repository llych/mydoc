###安装Visual Studio Code

    首先需要安装Ubuntu Make。Ubuntu Make存在Ubuntu 15.04资源库中，但需要Ubuntu Make 0.7以上版本才能安装Visual Studio。
    所以，需要通过官方PPA更新到最新的Ubuntu Make，支持Ubuntu 14.04、14.10和15.04，但仅64位版本。
    
    打开终端，使用下列命令，通过官方PPA来安装Ubuntu Make：
    
    sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
    sudo apt-get update
    sudo apt-get install ubuntu-make
    
    安装Ubuntu Make完后，接着使用下列命令安装Visual Studio Code：
    umake web visual-studio-code

　
　
###卸载Visual Studio Code，同样使用Ubuntu Make命令。

    umake web visual-studio-code remove
