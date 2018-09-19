# This is the default target, which will be built when you invoke make
.PHONY: all
all: hello

# This rule tells make how to build hello from hello.cpp
hello: hello.cpp
	g++ -o hello hello.cpp
