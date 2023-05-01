check_or_download_zip_file() {
    if ! ls platform-tools*.zip 1> /dev/null 2>&1; then # 如果不存在就下载
    
        redirect_url=$(curl -sI https://dl.google.com/android/repository/platform-tools-latest-linux.zip \
        | grep -i location | awk '{ print $2 }' | tr -d '\r') # 这是个重定向链接
        curl -O $redirect_url
        if ! ls platform-tools*.zip 1> /dev/null 2>&1; then #如果还不存在就报错退出
            echo "Failed to download zip file"
            exit 1
        fi
    fi
}

# 调用函数
check_or_download_zip_file

#解压
zip_file=$(ls platform-tools*.zip 2>/dev/null | head -n 1)
current_dir=$(pwd)
echo $current_dir $zip_file

if [ ! -d "platform-tools" ]; then
    unzip $zip_file -d $current_dir 
fi

# 把adb和fastboot添加到环境路径 ~/.profile
add_android_sdk_to_path() {
    local current_dir="$1"
    local profile_file="$HOME/.profile"
    
    text_to_add="# add Android SDK platform tools to path\nif [ -d \"$current_dir/platform-tools\" ] ; then\n    export PATH=\"$current_dir/platform-tools:\$PATH\"\nfi\n"
    
    # check if platform-tools directory exists
    if [ -d "$current_dir/platform-tools" ]; then
        # add platform-tools directory to PATH
        if ! grep -q "platform-tools" "$profile_file"; then
            echo -e "$text_to_add" >> "$profile_file"
            echo "Added Android SDK platform tools to PATH in $profile_file"
        else
            echo "Android SDK platform tools are already added to PATH in $profile_file"
        fi
    else
        echo "Android SDK platform tools directory not found in $current_dir"
    fi
}
add_android_sdk_to_path $current_dir
echo "**Please exec 'source ~/.profile' in terminal manually.**"








