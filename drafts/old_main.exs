
# Language Python Parser
#
# Carla Perez Gavilan
# Gerardo Angeles A01338190
# David Medina A01653311

# To run the program
# Parser.main("Random.py", "prueba.html")

defmodule Parser do

@moduledoc """
  A model that implements functions for performing a parser for
  the pyhton programming language
  """

  @doc """
  A module that recieves a python file and returns and html file
  """
  def main(in_filename, out_filename) do

    new_content =
      in_filename
      #real file
      |> read_file()
      # all the line process
      |> process_line()
      #join the lines with new lines
      |> Enum.join("\n")
      # add the HTML body document
      |> add_HTML_base_information(out_filename)

    write_file(out_filename, new_content)

  end


  @doc """
  Recieves name of file returns lines in file in list form
  """
  def read_file(file_name) do
    file_name
    |> File.stream!()
    |> Enum.map(&String.trim/1)
  end

  @doc """
  Process each line
  """
  def process_line(line) do
    new_content =
      line
      #search for the symbol # to decide that line is a comment
      |> Enum.map(&comment_search(&1))
      #if no comment line, search fot keywords, variables, operators, functions
      #,etc
      |> Enum.map(&not_comment_identifier(&1))
      #add the html information to a line
      |> Enum.map(&format_html(&1))
  end

  @doc """
  to analize the lines that arent comments
  """
  def not_comment_identifier(line) do
    #no comment line
    if Regex.run(~r/^((?!#).)*$/, line) do
      #split line
      String.split(line, " ")
      # search for keywords
      |> Enum.map(&keyword_identify(&1))
      #HERE ADD THE OTHER FUNCTIONS FOR SEARCH VARIABLES, NUMBERS, FUNCTIONS,
      #ETC.
      ############# (here all the operators are identiifed)
      |> Enum.map(&arithmetic_operator_identify(&1))
      |> Enum.map(&comparison_operator_identify(&1))
      |> Enum.map(&bitwise_operator_identify(&1))
      |> Enum.map(&assigment_operator_identify(&1))
      #############
      |> Enum.join(" ")
    else
      #if line return normal line
      line
    end
  end

  @doc """
  Search for comments and add the corresponding tag
  """
  def comment_search(to_analize) do
    Regex.replace(~r/(#(.*))/, to_analize, &add_information(&1, "comment") ,
    global: false)
  end

  @doc """
  Add the HTML information to the document
  """
  def add_HTML_base_information(body, out_filename) do
    content =
      "<!doctype html>
      <html lang='en'>
          <head>
              <meta charset='utf-8'>
              <title>#{out_filename}</title>
              <style>
                  .comment {color: gray;}
                  .keyword {color: blue;}
                  .parenthesis {color: rgb(255, 0, 72)}
                  .string {color:rgb(84, 216, 23)}
                  .normalText {color: rgb(0, 0, 0)}
                  .function {color:rgb(255, 170, 0)}
                  .integer {color: darkgreen;}
                  .arithmetic_operators {color: rgb(50,90,150) }
                  .comparison_operators {color: rgb(200,70,110)}
                  .assigment_operators {color: rgb(100,0,10) }
                  .bitwise_operators {color : rgb(180,100,200)}
              </style>
          </head>
          <body>
          <pre>"
            <> body <>
          "</pre></body>
      </html>"
  end

  @doc """
  function to add style to specific part with the corresponding class
  """
  def add_information(text, class) do
    "<span class=#{class}>#{text}</span>"
  end

  @doc """
  Write output back to file
  """
  def write_file(file_name, content) do
    File.write!(file_name, content)
  end

  @doc """
  Returns line in html format
  function to add the HTML information to the line
  """
  def format_html(line) do
    "#{line}"
  end

  @doc """
  Key word identifier: recieves line identifies keywords and gives them a
  different color in output file
  """
  def keyword_identify(line) do
    #Regex.replace(~r/(^((?!#).)*) *((and)|(exec)|(not)|(assert)|(finally)|(or)
    #|(break)|(for)|(pass)|(class)|(from)|(print)|(continue)|(global)|(raise)|
    #(def)|(if)|(return)|(del)|(import)|(try)|(elif)|(in)|(while)|(else)|(is)|
    #(with)|(except)|(lambda)|(yield)) +/, line,
    #&add_information(&1, "keyword") , global: false)
    Regex.replace(~r/^((and)|(exec)|(not)|(assert)|(finally)|(or)|(break)|(for)
    |(pass)|(class)|(from)|(print)|(continue)|(global)|(raise)|(def)|(if)|
    (return)|(del)|(import)|(try)|(elif)|(in)|(while)|(else)|(is)|(with)|
    (except)|(lambda)|(yield))$/, line,
    &add_information(&1, "keyword"), global: false)
  end

  @doc """
  arithmetic operators identifier: recieves a line identifies arithemtic
  operators and gives them a different color in output file
  """
  def arithmetic_operator_identify(line) do
    Regex.replace(~r'^((\+)|(-)|(\*)|(/)|(%)|(\*\*)|(//))$', line,
    &add_information(&1, "arithmetic_operators") , global: false)
  end

  @doc """
  Comparison perators identifier: recieves a line, identifies comparison
  operators and gives them a different color in output file
  """
  def comparison_operator_identify(line) do
    Regex.replace(~r'^((==)|(!=)|(>)|(<)|(>=)|(<=))$', line,
    &add_information(&1, "comparison_operators") , global: false)
  end

  @doc """
  Bitwise perators identifier: recieves a line, identifies operators and
  gives them a different color in output file
  """
  def bitwise_operator_identify(line) do
    Regex.replace(~r/^((&)|(|)|(^)|(~)|(<<)|(>>))$/, line,
    &add_information(&1, "bitwise_operators") , global: false)
  end

  @doc """
  Assigent Operators identifier:: recieves a line, identifies assigment
  operators and gives them a different color in output file
  """
  def assigment_operator_identify(line) do
    Regex.replace(~r'^((=)|(\+=)|(-=)|(\*=)|(\/=)|(%=))$', line,
    &add_information(&1, "assigment_operators") , global: false)
  end

  @doc """
  Variable identifier: recieves a line identifies variables and gives them a
  different color in output file
  """
  def variable_identify(line) do

  end

end
