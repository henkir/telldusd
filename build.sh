#!/bin/sh

mkdir /tmp/telldus
cd /tmp/telldus
wget http://download.telldus.com/TellStick/Software/telldus-core/telldus-core-2.1.2.tar.gz
tar zxvf telldus-core-2.1.2.tar.gz
cd telldus-core-2.1.2

awk '
NR==FNR { rep = rep $0 OFS; next }
/FIND_PACKAGE(Doxygen)/ { printf "%s", rep; inBlock=1 }
!inBlock
/ENDIF()/ { inBlock=0 }
' CMakeLists.txt.modified CMakeLists.txt
mv CMakeLists.txt.modified CMakeLists.txt
sed -i '4i set(CMAKE_CXX_FLAGS "-std=c++98")' CMakeLists.txt
cmake . -DCMAKE_INSTALL_PREFIX=/usr
sed -i '1 s/$/ -pthread/' tdtool/CMakeFiles/tdtool.dir/link.txt
sed -i '1 s/$/ -pthread/' tdadmin/CMakeFiles/tdadmin.dir/link.txt
sed -i '11i #include <ctime>' service/Sensor.h
sed -i '11i #include <pthread.h>' common/common.h
sed -i 's/cfg >/cfg !=/g' service/SettingsConfuse.cpp
make
make install
