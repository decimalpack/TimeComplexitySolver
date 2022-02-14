# Time Complexity Solver

## About

- This program uses the doubling method to derive the **polynomial** time complexity of a given program.
- This is more like a proof of concept rather than a practical tool

## Requirements

- The target program must accept $N$ as the sole CLI argument.
- You must specify the bounds of N using the command line arguments. It works better for large values of $N$, hence increase the *maximum_size* as much as possible

## Example
```python
# fact.py
# Target Program
import sys

def factorial(N):
    if N==0: return 1
    return N*factorial(N-1)

N = int(sys.argv[1])
print(factorial(N))
```

```shell
./main -m=100 -M=20000000 --warmup=10 "python3 fact.py" 
# Outputs: 
# Input 13107200 took 0.0009240060000000015
# 6.598349999999992e-06 * N^1
```

## References
- <https://www.cs.princeton.edu/courses/archive/fall09/cos126/lectures/08Analysis-2x2.pdf>