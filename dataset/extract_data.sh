#!/bin/bash
set -e  # 遇到错误就退出

SRC_TAR="ILSVRC2012_img_test.tar"
DST_DIR="/mnt/data/ImageNet/test"

# 1. 创建目标目录
mkdir -p "$DST_DIR"

echo "==> 解压主tar包到 $DST_DIR ..."
tar -xvf "$SRC_TAR" -C "$DST_DIR"

# 2. 进入目标目录，逐个解压子tar
cd "$DST_DIR"
echo "==> 解压每个类别的tar包 ..."
for f in *.tar; do
    class_dir="${f%.tar}"
    mkdir -p "$class_dir"
    echo "   -> 正在解压 $f 到 $class_dir/"
    tar -xf "$f" -C "$class_dir"
    rm "$f"   # 删除子tar，节省空间
done

echo "==> 完成！ImageNet 训练集已解压到 $DST_DIR"
