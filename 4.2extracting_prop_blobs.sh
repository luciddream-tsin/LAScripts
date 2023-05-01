current_dir=$(pwd)

cd $current_dir/android

if [ ! -d "system_dump" ]; then
    mkdir -p $current_dir/android/system_dump
fi

cd system_dump

if ! ls system.*.br 1> /dev/null 2>&1; then 
    unzip $current_dir/lineage-*.zip system.transfer.list system.new.dat*
fi

if ! ls vendor.*.br 1> /dev/null 2>&1; then 
    unzip $current_dir/lineage-*.zip vendor.transfer.list vendor.new.dat*
fi

sudo apt-get install -y brotli 

if ! ls system.*.dat 1> /dev/null 2>&1; then 
    brotli --decompress --output=system.new.dat system.new.dat.br
fi

if ! ls vendor.*.dat 1> /dev/null 2>&1; then 
    brotli --decompress --output=vendor.new.dat vendor.new.dat.br
fi



if [ ! -d "sdat2img" ]; then
    git clone https://github.com/xpirt/sdat2img
fi


if ! ls system.img 1> /dev/null 2>&1; then 
    python sdat2img/sdat2img.py system.transfer.list system.new.dat system.img

fi
if ! ls vendor.img 1> /dev/null 2>&1; then 
    python sdat2img/sdat2img.py vendor.transfer.list vendor.new.dat vendor.img

fi

if [ ! -d "system" ]; then
    mkdir system/
    sudo mount system.img system/

    sudo rm -rf system/vendor
    sudo mkdir system/vendor
    sudo mount vendor.img system/vendor/
fi

    
cd $current_dir/android/lineage/device/xiaomi/chiron
./extract-files.sh $current_dir/android/system_dump/

sudo umount $current_dir/android/system_dump/system/vendor
sudo umount $current_dir/android/system_dump/system
rm -rf $current_dir/android/system_dump/

