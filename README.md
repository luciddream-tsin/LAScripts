# LAScripts
All Scripts for Build Lineage Android OS.

## 5.breakfast.sh
使用breakfast chiron 会出现bug,而且不会下载我们需要的设备特定信息和kernel，方案是不添加chiron,而是根据他的提示手动选择。
4.1是没有发现解决方案前，试图手动下载硬件信息的代码，但是并不能工作，后面的操作编译系统也不能发现识别设备树。

4.2 下载一个编译好的lineage刷机包放在同目录下，提取vendor等