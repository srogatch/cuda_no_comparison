ifeq ($(dbg),1)
	NVCCFLAGS += -g -G
else
	NVCCFLAGS += -O3 -Xcompiler -g3
endif

ifdef NVCC_BITS
	NVCCFLAGS += -m $(NVCC_BITS)
endif

ifdef NVCC_VERBOSE
	NVCCFLAGS += -Xptxas="-v"
endif

NVCCFLAGS	+= $(INCLUDES) -m64 -Xptxas -lineinfo -rdc=true -default-stream per-thread

all: build

build: no_comparison

no_comparison.o: no_comparison.cu
	nvcc $(NVCCFLAGS) -o $@ -c $< -Xcompiler -fopenmp
	nvcc $(NVCCFLAGS) -o $@.asm -Xcompiler -S -c $< -Xcompiler -fopenmp

no_comparison: no_comparison.o
	nvcc $(NVCCFLAGS) -o $@ $+ -lgomp

clean:
	rm -f no_comparison.o no_comparison

clobber:
	clean
