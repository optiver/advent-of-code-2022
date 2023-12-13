/// This module contains functions to solve day 9 of advent of code 2023

/// Takes a string containing a space seperated line of signed integers,
/// returning the parsed integers in a Vec, or an error message
fn parse_line(line: &str) -> Result<Vec<i64>, String> {
    line.split(' ')
        .map(|token| {
            token
                .parse::<i64>()
                .map_err(|err| format!("when parsing {:?}, {:}", token, err))
        })
        .collect()
}

/// Takes a sequence as input, and returns the a list of the differences at each step
fn sequence_diffs(sequence: &[i64]) -> Vec<i64> {
    sequence
        .iter()
        .zip(sequence.iter().skip(1))
        .map(|(prev, curr)| curr - prev)
        .collect()
}

/// Takes a sequence, and returns the next value in the sequence, according to the rules
/// given in day 9
/// If it is not possible to find the next number in the sequence, returns None
fn next_in_sequence(sequence: &[i64]) -> Option<i64> {
    // If the sequence is empty, then the starting sequence was not valid
    if sequence.is_empty() {
        return None;
    }
    // If all numbers in the sequence are 0, return 0
    if sequence.iter().all(|&n| n == 0) {
        return Some(0);
    }

    let diffs = sequence_diffs(sequence);
    let next_diff = next_in_sequence(&diffs);
    Some(sequence.last()? + next_diff?)
}

/// Parses the contents of the input file for day 9, or returns an error message
fn parse_input_to_numbers(input: &str) -> Result<Vec<Vec<i64>>, String> {
    let lines = input.split('\n');
    let non_empty_lines = lines.filter(|line| !line.is_empty());

    let numbers_or_err: Result<Vec<Vec<i64>>, _> = non_empty_lines.map(parse_line).collect();
    let numbers = numbers_or_err.map_err(|err| err.to_string())?;
    Ok(numbers)
}

/// Solves part A when reverse is false, and part B when reverse is true
/// Returns an error message for unsolvable input
pub fn solve(input: &str, reverse: bool) -> Result<i64, String> {
    let mut numbers = parse_input_to_numbers(input)?;
    // extrapolating backwards has the same result as reversing the numbers in a sequence, then extrapolating forward
    // So we reverse each row of numbers to solve part B
    if reverse {
        numbers = numbers
            .into_iter()
            .map(|line| line.into_iter().rev().collect())
            .collect();
    }
    let next_numbers_or_err: Result<Vec<i64>, _> = numbers
        .iter()
        .map(|numbers| {
            next_in_sequence(numbers).ok_or_else(|| {
                format!(
                    "reached a sequence of length 1 when finding next in sequence {:?}",
                    numbers
                )
            })
        })
        .collect();
    let next_numbers = next_numbers_or_err?;

    let sum_next_values = next_numbers.iter().sum::<i64>();
    Ok(sum_next_values)
}

#[must_use]
pub fn solve_part_a(input: &str) -> Result<i64, String> {
    solve(input, false)
}

#[must_use]
pub fn solve_part_b(input: &str) -> Result<i64, String> {
    solve(input, true)
}

#[cfg(test)]
mod tests {
    use std::fs;

    use crate::day9::{solve_part_a, solve_part_b};

    fn test_part_a_with_file(file_name: &str, expected_result: Result<i64, String>) {
        let text = fs::read_to_string(file_name).unwrap();
        let result = solve_part_a(&text);
        assert_eq!(expected_result, result);
    }

    fn test_part_b_with_file(file_name: &str, expected_result: Result<i64, String>) {
        let text = fs::read_to_string(file_name).unwrap();
        let result = solve_part_b(&text);
        assert_eq!(expected_result, result);
    }

    #[test]
    fn part_a_valid_example() {
        test_part_a_with_file("input/example_input.txt", Ok(107));
    }

    #[test]
    fn part_b_valid_example() {
        test_part_b_with_file("input/example_input.txt", Ok(3));
    }

    #[test]
    fn part_a_bad_parse() {
        test_part_a_with_file(
            "input/example_bad_parse.txt",
            Err("when parsing \"26f\", invalid digit found in string".to_owned()),
        );
    }

    #[test]
    fn part_b_bad_parse() {
        test_part_b_with_file(
            "input/example_bad_parse.txt",
            Err("when parsing \"26f\", invalid digit found in string".to_owned()),
        );
    }

    #[test]
    fn part_a_unsolvable_sequence() {
        test_part_a_with_file(
            "input/example_unsolvable_sequence.txt",
            Err("reached a sequence of length 1 when finding next in sequence [1, 4]".to_owned()),
        );
    }

    #[test]
    fn part_b_unsolvable_sequence() {
        test_part_b_with_file(
            "input/example_unsolvable_sequence.txt",
            Err("reached a sequence of length 1 when finding next in sequence [4, 1]".to_owned()),
        );
    }
}
