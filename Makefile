# This is the default target, which will be built when you invoke make
.PHONY: all
all: hello hello_mpi

# This rule tells make how to build hello from hello.cpp
hello: hello.cpp
	g++ -o hello -std=c++14 hello.cpp

hello_mpi: hello_mpi.cpp
	mpicxx -o hello_mpi hello_mpi.cpp

clean:
	rm -rf build*
	rm hello hello_mpi
