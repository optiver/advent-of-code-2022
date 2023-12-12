mod day9;

use std::env;
use std::fs;

use day9::solve_part_a;
use day9::solve_part_b;

fn print_output(output: Result<i64, String>, part: &str) {
    match output {
        Ok(number) => println!(
            "The number of sum of extrapolated values for {:} is: {:}",
            part, number
        ),
        Err(error) => println!("Error solving {:}: {:}", part, error),
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();

    assert!(args.len() <= 2, "Expected at most 1 argument");

    let file_path = args.get(1).map_or("input/example_input.txt", |s| &**s);
    let text = fs::read_to_string(file_path).unwrap();

    print_output(solve_part_a(&text), "part A");
    print_output(solve_part_b(&text), "part B");
}
