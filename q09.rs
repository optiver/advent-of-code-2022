// rust solution with proper error handling and reasonable performance
// to compile: rustc -O q09.rs
// to run: q09 <input_file>
use std::{
    error::Error,
    fs::File,
    io::{BufRead, BufReader},
    num::ParseIntError,
    str::FromStr,
};

#[derive(Clone)]
pub struct History {
    history: Vec<isize>,
}

impl History {
    // For non-rust-users: these methods take self by value, which means this History cannot be reused. This way we
    // are sure we can safely alter the data without copying or allocating memory.
    pub fn extrapolate_forward(mut self) -> Result<isize, &'static str> {
        let mut sum = 0;
        while !self.is_all_zeros() {
            sum += self.history.last().unwrap();
            self.convert_to_differences();
        }
        if self.history.is_empty() {
            Err("Invalid data: derivative does not stabilize to 0")
        } else {
            Ok(sum)
        }
    }

    pub fn extrapolate_backward(mut self) -> Result<isize, &'static str> {
        self.history.reverse();
        self.extrapolate_forward()
    }

    fn is_all_zeros(&self) -> bool {
        self.history.iter().all(|e| *e == 0)
    }

    fn convert_to_differences(&mut self) {
        assert!(!self.history.is_empty());
        for i in 0..self.history.len() - 1 {
            self.history[i] = self.history[i + 1] - self.history[i];
        }
        self.history.pop();
    }
}

impl FromStr for History {
    type Err = ParseIntError;
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let history: Result<_, _> = s.split(' ').map(isize::from_str).collect();
        Ok(History { history: history? })
    }
}

pub fn main() -> Result<(), Box<dyn Error>> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() == 2 {
        let input = BufReader::new(File::open(&args[1])?);
        let mut forward_predictions = 0;
        let mut backward_predictions = 0;
        for line in input.lines() {
            let history = History::from_str(&line?)?;
            forward_predictions += history.clone().extrapolate_forward()?;
            backward_predictions += history.extrapolate_backward()?;
        }
        println!("forward: {forward_predictions}, backward: {backward_predictions}");
    } else {
        eprintln!("Usage: {} <input_file>", args[0]);
    }
    Ok(())
}
