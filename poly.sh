#!/usr/bin/bash

# Read CPU flags from /proc/cpuinfo
flags=$(grep -m 1 -oP '^flags\s*:\s*\K.*' /proc/cpuinfo)

# Check for AVX
if echo "$flags" | grep -q "\bavx\b"; then

        cd intel64-avx-poly128-g1; echo "\n---------------------------\nImplementation poly128-g1: \n---------------------------\n";
        make -f poly128_g1.mak; ./poly128_verify; ./poly128_record_speed; make clean -f poly128_g1.mak; cd ..;
        mkdir -p ./benchmarks/native/; mv ./benchmarks/poly128* ./benchmarks/native/;
    
        cd intel64-avx-polyval-g1; echo "\n---------------------------\nImplementation polyval-g1: \n---------------------------\n";
        make -f polyval_g1.mak; ./polyval_verify; ./polyval_record_speed; make clean -f polyval_g1.mak; cd ..;
        mkdir -p ./benchmarks/native/; mv ./benchmarks/polyval* ./benchmarks/native/;
    
        cd intel64-avx-poly256-g1; echo "\n---------------------------\nImplementation poly256-g1: \n---------------------------\n";
        make -f poly256_g1.mak; ./poly256_verify; ./poly256_record_speed; make clean -f poly256_g1.mak; cd ..;
        mkdir -p ./benchmarks/native/; mv ./benchmarks/poly256* ./benchmarks/native/;
    
        cd intel64-avx-polyval256-g1; echo "\n------------------------------\nImplementation polyval256-g1: \n------------------------------\n";
        make -f polyval256_g1.mak; ./polyval256_verify; ./polyval256_record_speed; make clean -f polyval256_g1.mak; cd ..;
        mkdir -p ./benchmarks/native/; mv ./benchmarks/polyval256* ./benchmarks/native/;
    
        cd intel64-avx-poly512-g1; echo "\n---------------------------\nImplementation poly512-g1: \n---------------------------\n";
        make -f poly512_g1.mak; ./poly512_verify; ./poly512_record_speed; make clean -f poly512_g1.mak; cd ..;
        mkdir -p ./benchmarks/native/; mv ./benchmarks/poly512* ./benchmarks/native/;
    
        cd intel64-avx-polyval512-g1; echo "\n------------------------------\nImplementation polyval512-g1: \n------------------------------\n";
        make -f polyval512_g1.mak; ./polyval512_verify; ./polyval512_record_speed; make clean -f polyval512_g1.mak; cd ..;
        mkdir -p ./benchmarks/native/; mv ./benchmarks/polyval512* ./benchmarks/native/;
    
else
        printf "Your CPU does not support the least required instruction sets for the software!\n"
fi
