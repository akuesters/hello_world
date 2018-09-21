// 'Hello World!' program 
 
#include <iostream>
#include <memory> 

struct Vec3
{
    int x, y, z;
    Vec3() : x(0), y(0), z(0) { }
    Vec3(int x, int y, int z) :x(x), y(y), z(z) { }
    friend std::ostream& operator<<(std::ostream& os, Vec3& v) {
        return os << '{' << "x:" << v.x << " y:" << v.y << " z:" << v.z  << '}';
    }
};

int main()
{
  auto v = std::make_unique<Vec3>();
  std::cout << "Heeeeelllloooooooo!" << std::endl;
  std::cout << "Testing Travis CI on Mac!" << std::endl;
  std::cout << "Testing Travis CI on Linux!" << std::endl;
  std::cout << "Testing C++14 make_unique<Vec3>(): " << *v << '\n';
  return 0;
}
