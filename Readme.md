# Time Complexity Solver

## About

- This program uses the doubling method to derive the **polynomial** time complexity of a given program.
- This is more like a proof of concept rather than a practical tool

## Requirements

- The target program must accept $N$ as the sole CLI argument.
- You must specify the bounds of N using the command line arguments. It works better for large values of $N$, hence increase the *maximum_size* as much as possible

## Example
```python
# insertionSort.py
# Target Program
import sys


def insertionSort(arr):
    for i in range(1, len(arr)):
        key = arr[i]
        j = i - 1
        while j >= 0 and key < arr[j]:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = key
    return arr


N = int(sys.argv[1])
# best = list(range(N))[::-1] # O(N^2)
best = list(range(N)) # O(N)
print(insertionSort(best))
```

```shell
 ./main -m=128 -M=20000 -w=10 "python3 insertionSort.py"
# Outputs: 

# Worst Case
# Input 16384 took 18 seconds, 860 milliseconds, 852 microseconds, and 214 nanoseconds
# 1274.018112000001 * N^2

# Best Case
#Input 16384 took 39 milliseconds, 890 microseconds, and 946 nanoseconds
#291802.65625 * N^1
```

## References
- <https://www.cs.princeton.edu/courses/archive/fall09/cos126/lectures/08Analysis-2x2.pdf>