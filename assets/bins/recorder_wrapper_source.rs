use std::fs;
use std::io::{BufRead, BufReader};
use std::process::{Command, Stdio};

fn main() {
    let file_path = "/tmp/recorded_video.mp4";

    match fs::remove_file(file_path) {
        Ok(_) => println!("File deleted successfully"),
        Err(_) => {}
    }

    let mut child = Command::new("wf-recorder")
        .arg("-c").arg("h264_vaapi")
        .arg("-d").arg(detect_render_device())
        .arg("-F").arg("scale_vaapi=format=nv12:out_range=full")
        .arg("-p").arg("color_range=full")
        .arg("-f").arg(file_path)
        .arg("-g").arg(slurp())
        .arg("--audio=alsa_output.usb-C-Media_Electronics_Inc._USB_PnP_Sound_Device-00.analog-stereo-output.monitor")
        .stderr(Stdio::piped())  // READ STDERR
        .spawn()
        .expect("Failed to spawn process");

    let stderr = child.stderr.as_mut().expect("Failed to open stderr");
    let reader = BufReader::new(stderr);

    // notify only once
    let mut notified = false;

    for line in reader.lines() {
        match line {
            Ok(line) => {
                if !notified && line.contains("Output #0") {
                    notify("Recording Started");
                    notified = true;
                }
            }
            Err(err) => eprintln!("Error reading stderr: {}", err),
        }
    }

    let status = child.wait().expect("Failed to wait on child process");
    copy_to_clipboard(&format!("file://{}", file_path));
    notify(&format!("Recording Ended ({})", status));
}

fn notify(msg: &str) {
    Command::new("notify-send")
        .arg(msg)
        .arg("-t")
        .arg("1000")
        .spawn()
        .expect("error idk how")
        .wait()
        .expect("error again idk how");
}

fn slurp() -> String {
    let geo: String;
    let output = Command::new("slurp").output().expect("error again idk how");

    if output.status.success() {
        geo = String::from_utf8_lossy(&output.stdout).to_string();
    } else {
        let stderr = String::from_utf8_lossy(&output.stderr);
        eprintln!("Process failed with error:\n{}", stderr);
        geo = "".to_string();
    }

    geo
}

fn copy_to_clipboard(text: &str) {
    Command::new("wl-copy")
        .arg(text)
        .arg("--type")
        .arg("text/uri-list")
        .spawn()
        .expect("error idk how")
        .wait()
        .expect("error again idk how");
}

fn detect_render_device() -> String {
    if std::path::Path::new("/dev/dri/renderD128").exists() {
        "/dev/dri/renderD128".to_string()
    } else {
        "/dev/dri/renderD129".to_string()
    }
}
