current_dir=$(pwd)

if [ ! -d "bin_tools" ]; then
    mkdir -p $current_dir/bin_tools
fi

if [ ! -d "android/lineage" ]; then
    mkdir -p $current_dir/android/lineage
fi

curl https://storage.googleapis.com/git-repo-downloads/repo > $current_dir/bin_tools/repo
chmod a+x $current_dir/bin_tools/repo

# repo添加到环境路径 ~/.profile
add_android_sdk_to_path() {
    local current_dir="$1"
    local profile_file="$HOME/.profile"

    text_to_add="if [ -d \"$current_dir/bin_tools\" ] ; then\n    export PATH=\"$current_dir/bin_tools:\$PATH\"\nfi\n"

    # check if platform-tools directory exists
    if [ -d "$current_dir/bin_tools" ]; then
        # add platform-tools directory to PATH
        if ! grep -q "bin_tools" "$profile_file"; then
            echo -e "$text_to_add" >> "$profile_file"
            echo "Added bin_tools to PATH in $profile_file"
        else
            echo "binbin_toolsare already added to PATH in $profile_file"
        fi
    else
        echo "bin_tools not found in $current_dir"
    fi
}

add_android_sdk_to_path $current_dir
source ~/.profile
echo "**Please exec 'source ~/.profile' in terminal manually.**"


# 配置git
git config --global user.email "chunfeng_tsin@163.com"
git config --global user.name "chunfeng_tsin"


# 配置ccache
if ! grep -q 'export USE_CCACHE=1' ~/.bashrc; then
  echo 'export USE_CCACHE=1' >> ~/.bashrc
fi

if ! grep -q 'export CCACHE_EXEC=/usr/bin/ccache' ~/.bashrc; then
  echo 'export CCACHE_EXEC=/usr/bin/ccache' >> ~/.bashrc
fi


#设置缓存的目录
if [ ! -d "ccache" ]; then
    mkdir -p $current_dir/ccache
fi

if ! grep -q "export CCACHE_DIR=$current_dir/ccache" ~/.bashrc; then
  echo "export CCACHE_DIR=$current_dir/ccache" >> ~/.bashrc
fi


source ~/.bashrc
  echo "may you should exec:source ~/.bashrc"

ccache -M 50G

cd $current_dir/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-20.0 --git-lfs












