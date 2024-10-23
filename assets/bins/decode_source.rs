use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let handle = stdin.lock();

    for line in handle.lines() {
        if let Ok(line) = line {
            if let Some((_, second_part)) = line.split_once(": ") {
                if let Some((index, second_part)) = second_part.split_once("|") {
                    println!("{}\t{}", index.to_string(), second_part);
                }
            }
        }
    }
}
