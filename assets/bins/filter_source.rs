use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let handle = stdin.lock();

    for (index, line) in handle.lines().enumerate() {
        if let Ok(line) = line {
            if let Some((index_2, second_part)) = line.split_once('\t') {
                println!("{}: {}|{}", index + 1, index_2, second_part);
            }
        }
    }
}
