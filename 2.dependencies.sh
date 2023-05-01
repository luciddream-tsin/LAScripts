
sudo apt-get update -y
sudo apt-get install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libwxgtk3.0-gtk3-dev

sudo apt-get install -y openjdk-11-jdk-headless


# 获取Python的版本号
python_version=$(python3 -c "import sys; print('{}.{}'.format(sys.version_info.major, sys.version_info.minor))")

# 检查Python版本是否为3.6或更高版本
if [[ $(echo "${python_version} >= 3.6" | bc -l) -eq 1 ]]; then
    echo "Python version is ${python_version}, which meets the requirement of 3.6 or higher."
else
    echo "---------------------------"
    echo "Python version is ${python_version}, which is lower than the requirement of 3.6 or higher."
    exit 1
fi
