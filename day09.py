#!/usr/bin/env python3
"""
Usage:  `python day09.py [path/to/input.txt]`
        input defaults to `day09.py`
"""


from itertools import pairwise
from typing import Iterable
import sys


def extrapolate(seq: list[int]) -> tuple[int, int]:
    if not any(seq):
        return 0, 0
    diffs = list(map(lambda pair: pair[1] - pair[0], pairwise(seq)))
    prev, nxt = extrapolate(diffs)
    return seq[0] - prev, seq[-1] + nxt


def solve(seqs: Iterable[list[int]]) -> tuple[int, int] :
    prevs, nexts = map(sum, zip(*map(extrapolate,  seqs)))
    return prevs, nexts


if __name__ == "__main__":
    inp = sys.argv[1] if len(sys.argv) > 1 else "day09.txt"
    seqs = (list(map(int, line.split())) for line in open(inp))
    prevs, nexts = solve(seqs)
    print(f"Part 1: {nexts}")
    print(f"Part 2: {prevs}")
