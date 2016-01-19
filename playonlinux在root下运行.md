###To Run PlayOnLinux As ROOT User

you will need to navigate to your PlayOnLinux directory which should be something like /usr/share/playonlinux/

in /usr/share/playonlinux/lib is where you will find the first file you need to edit called sources and comment them out by putting a # in front of these lines

    if [ "$(id -u)" = "0" ]
    then
    echo "PlayOnLinux is not supposed to be run as root. Sorry"
    exit
    fi
    
then edit /usr/share/playonlinux/python/mainwindow.­py and comment these lines

    if(os.popen("id -u").read() == "0\n" or os.popen("id -u").read() == "0"):
    wx.MessageBox(_("{0} is not supposed to be run as root. Sorry").format(os.environ["APP­LICATION_TITLE"]),_("Error&amp;quo­t;))
    os._exit(0)


To uninstall PlayOnLinux you need to run below given commands. :

    sudo apt-get install ppa-purge
    sudo ppa-purge ppa:ubuntu-wine/ppa
