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

if [[ "${WITH_DISTRIBUTED}" = "mpi" ]]; then
    echo "mpi        : on"
    export OMPI_CC=${CC}
    export OMPI_CXX=${CXX}
    CC="mpicc"
    CXX="mpicxx"
    echo `mpiexec --version`
    launch="mpiexec --oversubscribe -n 4"
    WITH_MPI="ON"
else
    echo "mpi        : off"
    launch=""
    WITH_MPI="OFF"
fi

#
# make build path
#
mkdir -p $build_path
cd $build_path

#
# run make
#
progress "Configuring with make"
cmake_flags="-DARB_WITH_ASSERTIONS=ON -DARB_WITH_MPI=${WITH_MPI} ${CXX_FLAGS}"
echo "cmake flags: ${cmake_flags}"

cd ../

if [[ "${WITH_MPI}" = "ON" ]]; then
    progress "make MPI version"
    make hello_mpi || error "unable to configure make"
else
    progress "make serial version"
    make hello || error "unable to configure make"
fi

cd $base_path

if [[ "${WITH_MPI}" = "ON" ]]; then
    progress "======== run MPI version ======="
    ${launch} ./hello_mpi
else
    progress "======== run serial version ======="
    ./hello
fi

progress "Cleaning make"
make clean

cd $base_path
