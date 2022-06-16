
# Language Python Parser
#
# Carla Perez Gavilan A01023033
# Gerardo Angeles A01338190
# David Medina A01653311

# To run the program: Parser.main("Random.py")

defmodule Parser do

  @moduledoc """
    A model that implements functions for performing a parser for
    the pyhton programming language
    """

    @doc """
    A module that recieves a python file and returns and html file
    """
    def main(in_filename) do
      out_filename = get_html_filename(in_filename)
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

      write_file(new_content, out_filename)
      

    end


    @doc """
    Recieves name of file returns lines in file in list form
    """
    def read_file(file_name) do
      file_name
      |> File.stream!()
      |> Enum.map(&String.trim_trailing/1)
    end


    @doc """
    Process each line, we make the recursive call
    """
    def process_line(line) do
      line
      |> Enum.map(&searcher(["", &1]))
    end


    @doc """
    Function that recieves a list, fists value is to save
    the line with the html format and the second value
    has the normal line information
    We search for every pattern, all regex functions start
    with ^ so we only search for the beginning of the line
    Sends the line with the new content, and the line with the rest for analyze
    If the for analyze is empty return the line with new content
    It is important the order of the calls, because it can identify
    something important in the everything else call, we need for not
    getting in a inifinity loop
    """
    def searcher(list) do
      [new_content, origin_line] = list
      if origin_line != "" do
        list
        |> keyword_identify()
        |> comment_search()
        # long comments 
        |> assigment_operator_identify()
        |> arithmetic_operator_identify()
        |> comparison_operator_identify()
        |> bitwise_operator_identify()
        |> special_caracter_identify()
        |> class_function_identify()
        |> variable_identify()
        |> digit_identify()
        |> string_identify()
        |> white_spaces_identify()
        |> invalid_identify()
        |> searcher()
      else
        new_content
      end
    end


    @doc """
    function to search and to implement all the identifiers
    """
    def identifier(regex_expression, clase_name, new_Content, line) do
      # IO.inspect("enter :"<>List.to_string(line))
      #defines if the regex functions apply to line, we use to
      #string because the line is a list
      if Regex.match?(~r/#{regex_expression}/, List.to_string(line)) do

        #if regex true, replace that part with the HTML format, and save it
        #add information add the HTML format
        new_content_regex =
          Regex.replace(~r/#{regex_expression}/, List.to_string(line),
          &add_information(&1, clase_name), global: false)
        IO.inspect("new_content_regex: "<>new_content_regex)
        #obtain the position of the last </span> in the new content regex
        #so we can split the line in already_formatted and rest of line
        array = Regex.run(~r/<\/span\>/, new_content_regex, return: :index)

        #add the start of the </span> position with the length so we have the
        #last > position
        position = Tuple.sum(List.last(array))

        #String.split_at returns a tuple so we save the values and create
        #a list so we can use it in out searcher function
        {already_formatted, rest_of_line} = String.split_at(new_content_regex, position)

        #join content we have already formatted with the new content formatted
        #and in a other element of the list the rest of line (not formatted)
        [Enum.join([new_Content, already_formatted]), rest_of_line]
      else
        #if the regex functions doesnt apply, return the info because we
        #this function is in a pipe operator
        [new_Content|line]
      end
    end


    @doc """
    Keyword identifier
    Key word identifier, search for all the keywords form python
    calls identifier, sends regex, add corresponding class and send content
    """
    def keyword_identify([new_Content | line]) do
      identifier("^((and)|(exec)|(not)|(assert)|(finally)|(or)|(break)|(for)|(pass)|(class)|(from)|(print)|(continue)|(global)|(raise)|(def)|(if)|(return)|(del)|(import)|(try)|(elif)|(in)|(while)|(else)|(is)|(with)|(except)|(lambda)|(yield))(?![a-zA-Z0-9])", "keyword", new_Content, line)
    end


    @doc """
    Search for the hash tag and everything else becomes a comment
    calls identifier, sends regex, add corresponding class and send content
    """
    def comment_search([new_Content | line]) do
      identifier("^(#(.*))", "comment", new_Content, line)
    end


    @doc """
    arithmetic operators identifier: recieves a line identifies arithemtic
    operators
    calls identifier, sends regex, add corresponding class and send content
    """
    def arithmetic_operator_identify([new_Content | line]) do
      identifier("^(([\x2B])|([\x2D])|([\x2A])|([\x2F])|([\x25])|([\x2A][\x2A])|([\x2F][\x2F]))",
      "arithmetic_operators", new_Content, line)
      #identifier("^((\+)|(-)|(\*)|(/)|(%)|(\*\*)|(//))", "arithmetic_operators", new_Content, line)
    end


    @doc """
    Comparison perators identifier: recieves a line, identifies comparison
    operators
    calls identifier, sends regex, add corresponding class and send content
    """
    def comparison_operator_identify([new_Content | line]) do
      identifier("^((>=)|(<=)|(==)|(!=)|(>)|(<))", "comparison_operator", new_Content, line)
    end


    @doc """
    Bitwise perators identifier: recieves a line, identifies operators
    calls identifier, sends regex, add corresponding class and send content
    """
    def bitwise_operator_identify([new_Content | line]) do
      identifier("^(([\x26])|([\x7C])|([\x7E])|([\x3C])([\x3C])|([\x3E])[\x3E])",
      "bitwise_operators", new_Content, line)
      #"^((\&)|(\|)|(\^)|(\~)|(\<\<)|(\>\>))"
    end


    @doc """
    Assigent Operators identifier:: recieves a line, identifies assigment
    operators
    calls identifier, sends regex, add corresponding class and send content
    """
    def assigment_operator_identify([new_Content | line]) do
      identifier("^(([\x3D])|([\x2B][\x3D])|([\x2D][\x3D])|([\x2A][\x3D])|([\x2F][\x3D])|([\x25][\x3D]))",
      "assigment_operators", new_Content, line)
      #"^((=)|(\+=)|(-=)|(\*=)|(\/=)|(%=))"
    end


    @doc """
    Special caracters identifier: searches for special caracters
    calls identifier, sends regex, add corresponding class and send content
    """
    def special_caracter_identify([new_Content | line]) do
      identifier("^(([\x3A])|([\x28])|([\x29])|([\x2E])|([\x2C])|([\x7B])|([\x7D])|([\x5B])|([\x5D]))",
      "special_operators", new_Content, line)
    end


    @doc """
    Digits identifier: the regex searches for any digits
    calls identifier, sends regex, add corresponding class and send content
    """
    def digit_identify([new_Content | line]) do
      identifier("^[0-9]+", "digit", new_Content, line)
    end


    @doc """
    Idenfity strings through regex
    """
    def string_identify([new_Content | line]) do
      identifier("^\".*?\"", "string", new_Content, line)
    end


    @doc """
    Identify variables through regex
    """
    def variable_identify([new_Content | line]) do
      identifier("^[_a-zA-Z][_a-zA-Z0-9]*", "variable", new_Content, line)
    end

   @doc """
    Identify variables through regex
    """
    def class_function_identify([new_Content | line]) do
      identifier("^([_a-zA-Z0-9]*\.)?[_a-zA-Z0-9]*(?=[\x28])", "class", new_Content, line)
    end

    @doc """
    White spaces identifier: calls identifier, sends regex, add corresponding class and send content
    """
    def white_spaces_identify([new_Content | line]) do
      identifier("^\s+", "white_spaces", new_Content, line)
    end

   @doc """
    Function that matches every letter, in case it doesn't match any of the other identifiers
    """
    def invalid_identify([new_Content | line]) do
        identifier("^([\S+]*)", "invalid", new_Content, line)
    end

    @doc """
    This function is called in identifier, it adds the corresponding
    HTML tag for the style, recive text and class
    """
    def add_information(text, class) do
      "<span class=#{class}>#{text}</span>"
    end


    @doc """
    Add the HTML information to the document, add body in the
    correspinding place
    body has all the new content formatted
    also recives the out filename for the title HTML tag
    """
    def add_HTML_base_information(body, out_filename) do
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
                  .white_space {color: black;}
                  .arithmetic_operators {color: rgb(50,90,150) }
                  .comparison_operators {color: rgb(200,70,110)}
                  .assigment_operators {color: rgb(100,0,10) }
                  .bitwise_operators {color : rgb(180,100,200)}
                  .invalid {color: rgb(130,50,40)}
                  .special_operators {color: rgb(10,150,140)}
                  .digit {color: rgb(229,170,130)}
                  .string {color: rgb(132, 230, 232)}
                  .variable {color: rgb(0, 227, 34)} 
                  .class {color: rgb(245, 66, 176)} 
              </style>
          </head>
          <body>
          <pre>"
            <> body <>
          "</pre></body>
      </html>"
    end

   @doc """
    Get file name without .py and switch to name.html
    """
    def get_html_filename(in_file) do
      name = Regex.run(~r/^[\S+]*(?=\.py)/, in_file)
      List.first(name)<>".html"
    end

    @doc """
    Write output back to file
    """
    def write_file(content, out_filename) do
      File.write!(out_filename, content)
    end


  end

