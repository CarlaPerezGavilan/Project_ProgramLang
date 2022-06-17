# Programming Language 

## Names of participants
Carla Perez Gavilan, A01023033<br />
Gerardo Angeles Hernandez, A01338190<br />
David Medina Medina, A01653311<br />

## Title of the project
_Language Parser_ - Identifies the programming language and identifies the used or reserved words 

## Description
#### Detailed description of the problem to be solved. Give as much information as possible. Assume the reader of the document is Jon Snow!
The problem we want to solve is understanding the structure of a programing language like Python, for different main reasons, for example, checking for syntax errors in a piece of code, identifying data, etc.
We are going to create a parser, the meaning of parser is: divide something into parts to examine each part individually. For out proyect we want to analyze relationships between components from a piece of code given.
The parse we want to develop is going to recieve commands and instructions and splits them, with the main purpose of understanding the structure of the language given and for a purpose in the future like gathering information, data analysts, etcetera.
Specifically, our project will recieve a name of a document, procces it, and generate a new HTML document with the respective colors for reserved keywords  of the language and other elements. It will also be able to identify variables and their type: global, constant, etc. The HTML document is going to simulate the function of an IDE, that helps you understand code using colors for language syntax elements.

## Programming Language 
#### Indicate the language you will use for your implementation. You can chose from the languages seen in class.
Elixir - to create the parser
Python - to analyze the language with the parser

## Explanation of your solution. 
#### Description of the functionality expected of your program, and specific examples of how you will use the topics listed above.
In this project, the parser will get as an input a plain text code that will generate an HTML and a CSS file for the output recognizing certain tokens from the text plain changing them the color.

For this project we are going to use the following topic:

-Functional programming: For this project we are going to use functional programming for solving it, just using functions that receives arguments and that gives another arguments at the output using recursion cycles for avoid using variables that affect the state of the function.<br />
-Recursion: Recursion will be used for reading the files for reading a line and calling the method for reading the next line and with patern matching do what is needed to do for each word of the lines.<br />
-List: Lists are going to be used for that all the lines in the code are readed one by one putting everyone of them inside of a list<br />
-File I|O: As previously mentioned, the input file is going to be a plain text file code of a programming language and the outputs are going to be an HTML and a CSS file.

## Functionality Diagram


## How to run the code instructions? 
1. Make sure you have installed elixir, with the following commands: 
```
sudo apt-get install elixir
```
For information on how to install on MacOs or Windows see the following link: https://elixir-lang.org/install.html

3. In the main directory run the following commands:

```
iex
c("main.exs")
Parser.main(<name_file>.py)
```
**IMPORTANT NOTE:** The file should be in python3 

3. Program will return a <name_file>.html file with the correct coloring


## Function Documentation
#### main(in_filename):
Main function that recieves .py file and returns .html file with correct coloring
#### read_file(file_name):
Function that reads file and returns list of lines (string format) in file



## References 
* Article on compilers: https://pgrandinetti.github.io/compilers/page/what-is-a-programming-language-parser/#:~:text=Parsing%20algorithms%20are%20not%20made,%2C%20valid%20for%20that%20grammar).
* A guide to parsing Algorithms:  https://tomassetti.me/guide-parsing-algorithms-terminology/ 
