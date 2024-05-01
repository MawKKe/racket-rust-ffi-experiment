#include <iostream>
#include <array>
#include <complex>
#include <complex.h>

struct Complex
{
    double a;
    double b;

    std::complex<double> to_native() const {
        return {a, b};
    }
};

extern "C" {
Complex rust_sum_complex(const Complex*, uint64_t);
}

int main(){
    std::array<Complex, 3> arr = {
        Complex{1,2},
        Complex{2,10},
        Complex{3,4},
    };

    std::cout << rust_sum_complex(nullptr, 0).to_native() << std::endl;
    std::cout << rust_sum_complex(arr.data(), arr.size()).to_native() << std::endl;
}
