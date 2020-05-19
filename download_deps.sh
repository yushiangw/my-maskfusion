

rm Core/Segmentation/MaskRCNN/numpy
ln -s `python3 -c "import numpy as np; print(np.__path__[0])"`/core/include/numpy Core/Segmentation/MaskRCNN || true # Provide numpy headers to C++

cd deps

# build pangolin
highlight "Building pangolin..."
#git_clone "git clone --depth=1 https://github.com/stevenlovegrove/Pangolin.git"
git clone --depth=1 https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
git pull
mkdir -p build
cd build
cmake -DAVFORMAT_INCLUDE_DIR="" -DCPP11_NO_BOOST=ON ..
make -j8
Pangolin_DIR=$(pwd)
echo Pangolin_DIR=$(pwd) > path_setting.txt
cd ../..


# git_clone "git clone --branch 3.4.1 --depth=1 https://github.com/opencv/opencv.git"
git clone --branch 3.4.1 --depth=1 https://github.com/opencv/opencv.git
cd opencv
mkdir -p build
cd build
cmake \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX="`pwd`/../install" \
\
`# OpenCV: (building is not possible when DBUILD_opencv_video/_videoio is OFF?)` \
-DWITH_CUDA=OFF  \
-DBUILD_DOCS=OFF  \
-DBUILD_PACKAGE=OFF \
-DBUILD_TESTS=OFF  \
-DBUILD_PERF_TESTS=OFF  \
-DBUILD_opencv_apps=OFF \
-DBUILD_opencv_calib3d=OFF  \
-DBUILD_opencv_cudaoptflow=OFF  \
-DBUILD_opencv_dnn=OFF  \
-DBUILD_opencv_dnn_BUILD_TORCH_IMPORTER=OFF  \
-DBUILD_opencv_features2d=OFF \
-DBUILD_opencv_flann=OFF \
-DBUILD_opencv_java=OFF  \
-DBUILD_opencv_objdetect=OFF  \
-DBUILD_opencv_python2=OFF  \
-DBUILD_opencv_python3=OFF  \
-DBUILD_opencv_photo=OFF \
-DBUILD_opencv_stitching=OFF  \
-DBUILD_opencv_superres=OFF  \
-DBUILD_opencv_shape=OFF  \
-DBUILD_opencv_videostab=OFF \
-DBUILD_PROTOBUF=OFF \
-DWITH_1394=OFF  \
-DWITH_GSTREAMER=OFF  \
-DWITH_GPHOTO2=OFF  \
-DWITH_MATLAB=OFF  \
-DWITH_NVCUVID=OFF \
-DWITH_OPENCL=OFF \
-DWITH_OPENCLAMDBLAS=OFF \
-DWITH_OPENCLAMDFFT=OFF \
-DWITH_TIFF=OFF  \
-DWITH_VTK=OFF  \
-DWITH_WEBP=OFF  \
..
make -j8
cd ../build
OpenCV_DIR=$(pwd)
cd ../..

# build OpenNI2
# highlight "Building openni2..."
# git_clone "git clone --depth=1 https://github.com/occipital/OpenNI2.git"
git clone --depth=1 https://github.com/occipital/OpenNI2.git
cd OpenNI2
git pull
make -j8
cd ..



# build freetype-gl-cpp
# highlight "Building freetype-gl-cpp..."
# git_clone "git clone --depth=1 --recurse-submodules https://github.com/martinruenz/freetype-gl-cpp.git"
git clone --depth=1 --recurse-submodules https://github.com/martinruenz/freetype-gl-cpp.git
cd freetype-gl-cpp
mkdir -p build
cd build
cmake -DBUILD_EXAMPLES=OFF -DCMAKE_INSTALL_PREFIX="`pwd`/../install" -DCMAKE_BUILD_TYPE=Release ..
make -j8
make install
cd ../..



# build DenseCRF, see: http://graphics.stanford.edu/projects/drf/
# highlight "Building densecrf..."
#git_clone "git clone --depth=1 https://github.com/martinruenz/densecrf.git"
git clone --depth=1 https://github.com/martinruenz/densecrf.git
cd densecrf
git pull
mkdir -p build
cd build
cmake \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -fPIC" \
..
make -j8
cd ../..



# build gSLICr, see: http://www.robots.ox.ac.uk/~victor/gslicr/
# highlight "Building gslicr..."
# git_clone "git clone --depth=1 https://github.com/carlren/gSLICr.git"
git clone --depth=1 https://github.com/carlren/gSLICr.git
cd gSLICr
git pull
mkdir -p build
cd build
cmake \
-DOpenCV_DIR="${OpenCV_DIR}" \
-DCMAKE_BUILD_TYPE=Release \
-DCUDA_HOST_COMPILER=/usr/bin/gcc \
-DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -D_FORCE_INLINES" \
..
make -j8
cd ../..


# Prepare MaskRCNN and data
# highlight "Building mask-rcnn with ms-coco..."
# git_clone "git clone --depth=1 https://github.com/matterport/Mask_RCNN.git"
# git_clone "git clone --depth=1 https://github.com/waleedka/coco.git"
# cd coco/PythonAPI
# make
# make install # Make sure to source the correct python environment first
# cd ../..
# cd Mask_RCNN
# mkdir -p data
# cd data
# wget --no-clobber https://github.com/matterport/Mask_RCNN/releases/download/v1.0/mask_rcnn_coco.h5
# cd ../..

# c++ toml
echo "Building toml11..."
#git_clone "git clone --depth=1 https://github.com/ToruNiina/toml11.git"
# git_clone "git clone --depth=1 --branch v2.4.0 https://github.com/ToruNiina/toml11.git"
git clone --depth=1 --branch v2.4.0 https://github.com/ToruNiina/toml11.git

cd ..
