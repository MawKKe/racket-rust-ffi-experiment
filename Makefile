run-racket-experiment:
	cargo build
	@echo "---"
	racket main.rkt

# Just to see if the complex business works
run-cxx-experiment: main.cc
	cargo build
	$(CXX) -std=c++17 -Wall -Wextra -pedantic main.cc -L./target/debug -lfoo -o main-cxx
	./main-cxx

clean:
	rm -rf target main.cxx a.out

.PHONY: run-racket-experiment run-cxx-experiment clean
