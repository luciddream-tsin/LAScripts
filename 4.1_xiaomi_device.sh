current_dir=$(pwd)
cd $current_dir/android/lineage/device

if [ ! -d "xiaomi" ]; then
    mkdir -p $current_dir/android/lineage/device/xiaomi
    cd xiaomi
    git clone https://github.com/LineageOS/android_device_xiaomi_chiron.git
    mv android_device_xiaomi_chiron/ chiron/
    
    
    git clone https://github.com/LineageOS/android_device_xiaomi_msm8998-common.git
    mv android_device_xiaomi_msm8998-common/ msm8998-common/
    
fi


