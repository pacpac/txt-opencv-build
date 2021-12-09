#!/bin/bash

set -e

echo "OpenCV clean build"

CVVERSION="4.0.0"

# Save current working directory
CWD=$(pwd)

# Clean build directories
rm -rf build install

# Create directory for installation
mkdir install
mkdir install/opencv-"$CVVERSION"

# Set swap to 512 MB
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=512/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start


#git clone https://github.com/opencv/opencv.git 
#git clone https://github.com/opencv/opencv.git -b $CVVERSION --depth 1
#cd opencv
#git checkout $CVVERSION
#cd $CWD
#or
#wget https://github.com/opencv/opencv/archive/refs/tags/$CVVERSION.tar.gz
#tar xzvf $CVVERSION.tar.gz

#git clone https://github.com/opencv/opencv_contrib.git
#cd opencv_contrib
#git checkout $cvVersion
#cd ..

# Create direcory for build
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -DCMAKE_INSTALL_PREFIX=$CWD/install/opencv-"$CVVERSION" \
            -DENABLE_VFPV3=ON \
            -DENABLE_NEON=ON \
            -DWITH_V4L=ON \
            ../opencv

make -j$(nproc)
make install
