#include <iostream>
#include <string>
#include <sstream>
#include <regex>
#include <cstdlib>
#include <algorithm>
#include <chrono>
#include <thread>

int main(int argc, char* argv[]) {
    int step = 40;
    std::string cmd = (argc > 1) ? argv[1] : "up";

    try {
        // Run ddcutil getvcp 10
        FILE* pipe = popen("ddcutil getvcp 10 2>&1", "r");
        if (!pipe) {
            throw std::runtime_error("Failed to run ddcutil");
        }

        std::string output;
        char buffer[128];
        while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
            output += buffer;
        }

        int ret = pclose(pipe);
        if (ret != 0) {
            std::cerr << "ddcutil returned non-zero: " << ret << std::endl;
        }

        // Parse current brightness
        std::regex re("current value\\s*=\\s*(\\d+)");
        std::smatch match;
        int current = 0;
        if (std::regex_search(output, match, re)) {
            current = std::stoi(match[1].str());
        } else {
            throw std::runtime_error("Could not parse current brightness");
        }

        std::cout << "Current brightness: " << current << std::endl;

        // Compute new brightness
        int new_brightness = current;
        if (cmd == "up") {
            new_brightness = std::min(current + step, 100);
        } else if (cmd == "down") {
            new_brightness = std::max(current - step, 0);
        }

        std::cout << "Setting brightness to: " << new_brightness << std::endl;

        // Safety: tiny delay to avoid spamming
        std::this_thread::sleep_for(std::chrono::milliseconds(50));

        // Set new brightness
        std::ostringstream set_cmd;
        set_cmd << "ddcutil setvcp 10 " << new_brightness << " --noverify";
        int set_ret = system(set_cmd.str().c_str());
        if (set_ret != 0) {
            std::cerr << "Error setting brightness" << std::endl;
        } else {
            std::cout << "Brightness set successfully!" << std::endl;
        }

    } catch (const std::exception& e) {
        std::cerr << "Unexpected error: " << e.what() << std::endl;
    }

    return 0;
}
