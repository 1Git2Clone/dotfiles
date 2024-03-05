#include <iostream>
#include <fstream>
#include <chrono>
#include <ctime>

int main(int argc, char* argv[]) {
    std::cout << "Feel free to write down stuff with markdown text!\n" << std::endl;

    std::ofstream todo_list("todo-list.md");

    if (!todo_list.is_open()) {
        std::cerr << "Error opening the file." << std::endl;
        return 1;
    }

    time_t now = time(0);
    char* dt = ctime(&now);
    todo_list << "# " << dt << std::endl;

    std::string title_input;
    std::cout << "Enter your title below." << std::endl;
    std::getline(std::cin, title_input);
    todo_list << "## " << title_input << std::endl;

    std::string input;
    std::cout << "Now enter your note text. (type: \"!quit\" in a new line to exit.)" << std::endl;
    while (std::getline(std::cin, input)) {
        if(input == "!quit") { break; }
        todo_list << input << std::endl;
    }

    todo_list.close();

    return 0;
}
