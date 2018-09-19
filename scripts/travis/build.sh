RED='\033[0;31m'
YELLOW='\033[0;33m'
CLEAR='\033[0m'

error()    {>&2 echo -e "${RED}ERROR${CLEAR}: $1"; exit 1;}
progress() { echo; echo -e "${YELLOW}STATUS${CLEAR}: $1"; echo;}

base_path=`pwd`
build_path=build-${BUILD_NAME}

#
# print build-specific and useful information
#
progress "build environment"

compiler_version=`${CXX} -dumpversion`
cmake_version=`cmake --version | grep version | awk '{print $3}'`

echo "compiler   : ${CXX} ${compiler_version}"
echo "cmake      : ${cmake_version}"
echo "build path : ${build_path}"
echo "base path  : ${base_path}"

#
# make build path
#
mkdir -p $build_path
cd $build_path

#
# run make
#
progress "Configuring with make"

cd ../
make

cd $base_path
