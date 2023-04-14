#include <iostream>
#include <random>

template<typename T> int FillData(T* data, int64_t count, T first, T step) {
  for(int64_t i=0; i<count; i++) {
    data[i] = first + i * step;
  }
}

template<typename T> int Test(const size_t count) {
  T* data;
  cudaMallocHost(&data, sizeof(T)*count);
  FillData(data, count, 0, 1);
  std::mt19937_64 rng;
  std::cout << data[rng() % count] << std::endl;
}

int main(int argc, char* argv[]) {
  Test<int>(atoi(argv[1]) * size_t(1000) * 1000);
  return 0;
}
