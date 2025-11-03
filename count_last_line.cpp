#include <iostream>
#include <fstream>
using namespace std;

int number_of_lines = 0;

int main(){
    number_of_lines--;
    cout<<"number of lines in text file: " << number_of_lines << endl;
}

void numberoflines(){
    string line;
    ifstream myfile("Notes.txt");
    if(myfile.is_open()){
        while(!myfile.eof()){
            getline(myfile,line);
            cout<< line << endl;
            number_of_lines++;
        }
        myfile.close();
    }
}