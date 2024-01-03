#include <iostream>
#include "Tools.h"

int main(int, char**){
    std::cout << "Hello, from LoggerApp!\n";
    //ZipFile("TestMe1.txt","TestFileZip.zip");
    ZipDirectory("Logs","Test.7z");
}
