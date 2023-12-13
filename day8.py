import numpy as np
from numpy import typing


def _get_input(input_data: list[str]) -> typing.NDArray:
    return np.array(
        [[int(number) for number in line.split()] for line in input_data],
        dtype=np.int32
    )


def part_one(input_data: list[str]):
    input_data = _get_input(input_data)

    state = input_data[:, -1]

    while not np.all(input_data == 0):
        input_data = np.diff(input_data)
        state += input_data[:, -1]

    answer = state.sum()

    return answer


def part_two(input_data: list[str]):
    input_data = _get_input(input_data)[:, ::-1]

    state = input_data[:, -1]

    while not np.all(input_data == 0):
        input_data = np.diff(input_data)
        state += input_data[:, -1]

    answer = state.sum()

    return answer


if __name__ == '__main__':
    with open("day8.txt") as f:
        data = f.readlines()
    part_one(data)
    part_two(data)
