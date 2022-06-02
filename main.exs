
# Language Parser
# 
# Carla Perez Gavilan 
# Gerardo Angeles 
# David Medina

defmodule Parser do 
@moduledoc """
  A module that recieves a python file and returns and html file 
  """

    @doc """
    Recieves name of file returns lines in file in list form
    """
    def read_file(file_name) do
    
    end 

     @doc """
    Process each line
        """
    def process_line(line) do
        # Call identify variables
        # Call identify operators
        # Call identify keywords
        # Format line html
    end

     @doc """
    Write output back to file 
    """
    def read_file(file_name) do
 
    end 

   @doc """
    Returns line in html format 
  """
    def format_html(line) do

    end 

    @doc """
    Key word identifier: recieves line identifies keywords and gives them a different color in output file 
    """
    def keyword_identify(line) do

    end

    @doc """
    Operator identifier (=, +, -, *): recieves a line identifies operators and gives them a different color in output file 
    """
    def  operator_identify(line) do
   
    end

    
    @doc """
    Variable identifier: recieves a line identifies variables and gives them a different color in output file 
    """
    def variable_identify(line) do
   
    end
end