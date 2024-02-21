#!/bin/sh

# Give error in script if an exception is happens.
set -e

# .tar.gz export the archive
echo "Archive exporting: deb_packages.tar.gz"
unzip deb_packages.zip || { echo  "Archive exporting is unsuccesfull!"; exit 1; }

# Compiling and installing for zlib-1.3 
echo "Compiling and installing: zlib-1.3"
cd zlib-1.3
mkdir -p build && cd build 
cmake .. || { echo  "CMake build is unsuccesfull!"; exit 1; }
make || { echo  "Compiling is unsuccesfull!"; exit 1; }
sudo make install || { echo  "Installing is unsuccesfull!"; exit 1; }
cd ../..

# Remove directory for zlib -1.3
echo "Remove directory for zlib -1.3"
sudo rm -r zlib-1.3/ || { echo  "Remove directory is unsuccesfull!"; exit 1; }

# Compiling and installing for libzip-1.10.1
echo "Compiling and installing: libzip-1.10.1"
cd libzip-1.10.1
mkdir -p build && cd build
cmake .. || { echo  "CMake build is unsuccesfull!"; exit 1; }
make || { echo  "Compiling is unsuccesfull!"; exit 1; }
sudo make install || { echo  "Installing is unsuccesfull!"; exit 1; }
cd ../..

# Remove directory for libzip-1.10.1
echo "Remove directory for libzip-1.10.1"
sudo rm -r libzip-1.10.1 || { echo  "Remove directory is unsuccesfull!"; exit 1; }

echo "All dependencies are installed succesfuly."
