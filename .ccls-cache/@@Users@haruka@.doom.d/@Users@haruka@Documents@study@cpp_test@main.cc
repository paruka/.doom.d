#include <iostream>
#include <string>

using namespace std;

class Complex {
public:
  constexpr Complex(int x) : x_{x} {
    std::cout << "Complex(int) " << x_ << " " << this << std::endl;
  }
  Complex() { std::cout << "Complex() " << x_ << " " << this << std::endl; }
  ~Complex() { std::cout << "~Complex() " << x_ << " " << this << std::endl; }
  Complex(const Complex &) = default;
  Complex &operator=(const Complex &) = default;
  Complex(Complex &&) = default;
  Complex &operator=(Complex &&) = default;
  int getX() const { return x_; }

private:
  int x_;
};

int main(int argc, char *argv[]) {
  constexpr int size = 3;
  Complex *ptr = new Complex[size]{1, 2, 3};
  for (int i = 0; i < size; ++i) {
    new (&ptr[i]) Complex(i);
  }
  delete[] ptr;

  return 0;
}
