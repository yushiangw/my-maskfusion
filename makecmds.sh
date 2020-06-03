mkdir -p build 

cd build
ln -s ../deps/Mask_RCNN ./ || true  
#cmake \
#  -DBOOST_ROOT="${BOOST_ROOT}" \
#cmake \
#  -DOpenCV_DIR="$(pwd)/../deps/opencv/build" \
#  -DPangolin_DIR="$(pwd)/../deps/Pangolin/build/src" \
#  -DMASKFUSION_PYTHON_VE_PATH="$(pwd)/../python-environment" \
#  -DCUDA_HOST_COMPILER=/usr/bin/gcc \
#  -DWITH_FREENECT2=OFF \
#  ..


cmake \
	  -DOpenCV_DIR="/media/ysdev/mycode/my-maskfusion/deps/opencv/build" \
	    -DPangolin_DIR="/media/ysdev/mycode/my-maskfusion/deps/Pangolin/build/src" \
	      -DMASKFUSION_PYTHON_VE_PATH="/media/ysdev/mycode/my-maskfusion/python-environment" \
	        -DCUDA_HOST_COMPILER=/usr/bin/gcc \
		  -DWITH_FREENECT2=OFF \
		  ..
		   # -DPYTHON_INCLUDE_DIR=/usr/include/python3.6m \
		   #   -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so.1 \





make -j 8
cd ..  
