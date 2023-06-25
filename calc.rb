# Copyright (c) 2023. Sihan Ma.
# All rights reserved.

# This is a calculator program where the next token in the scanner is passed
# into the calculator and parsed. The calculator then evaluates the calculator
# statements in the input where the resulting value is printed.

load "scan.rb"

class Calculator
  # initializes a new Calculator
  def initialize
    # prints a message to the user
    puts "Welcome to Calculator!"
    # hash map of variables and their corresponding values
    @variables = { "PI" => Math::PI }
    # reads input from the user
    while input = Readline.readline("> ", true)
      @scanner = Scanner.new(input)
      program
    end
  end

  # parses a program
  def program
    while @scanner.peek != nil
      # process the next token if it is not EOL
      if @scanner.peek.kind != "EOL"
        puts statement.to_s
      end
      @scanner.next_token
    end
  end

  # parses a statement
  def statement
    # look at the next token in the Scanner
    case @scanner.peek.kind
    when "id"
      # if the next token is not equal sign it's just a variable
      if @scanner.next.kind != "="
        return exp
      else
        id = @scanner.peek.value
        @scanner.next_token
        # if the next token is an equal sign, evaluate expression
        operator = @scanner.peek.kind
        if operator == "="
          @scanner.next_token
          value = exp
          # updates the hash map with the new variable and value
          @variables[id] = value
          return id.to_s + " is assigned to the value " + value.to_s
        end
      end
    when "clear"
      @scanner.next_token
      # removes the variable and value pair from the hash map
      id = @scanner.next_token.value
      @variables.delete(id)
      return "The variable " + id + " has been cleared."
    when "list"
      @scanner.next_token
      # prints all variable and value pair in the hash map
      @variables.each do | variable, value |
        puts variable.to_s + " = " + value.to_s
      end
      if @variables.empty?
        return "No variables are stored currently."
      else
        return "The above are all of the variables stored."
      end
    when "quit", "exit"
      @scanner.next_token
      # exits the program
      return exit
    else
      # if it is a number it's evaluated as an expression
      return exp
    end
  end

  # parses an expression
  def exp
    # process the first term
    result = term
    # if there's a plus or minus, that means there are more terms to parse
    while @scanner.peek.kind == "+" || @scanner.peek.kind == "-"
      operator = @scanner.next_token
      next_term = term
      # adds or subtracts the next term accordingly
      if operator.to_s == "+"
        result = result + next_term
      else
        result = result - next_term
      end
    end
    return result
  end

  # parses a term
  def term
    # process the first power
    result = power
    # if there's a multiplication sign or division sign,
    # that means there are more terms to parse
    while @scanner.peek.kind == "*" || @scanner.peek.kind == "/"
      operator = @scanner.next_token
      next_power = power
      # multiplies or divides the next term accordingly
      if operator.to_s == "*"
        result = result * next_power
      else
        result = result / next_power
      end
    end
    return result
  end

  # parses a power
  def power
    # process the first factor
    result = factor
    while @scanner.peek.kind == "**"
      @scanner.next_token
      @scanner.peek
      # processes the next power not next factor
      # so that it is right-associative
      next_power = power
      result = result ** next_power
    end
    return result
  end

  # parses a factor
  def factor
    current_token = @scanner.peek
    case current_token.kind
    when "id"
      # check if the variable is defined or not
      @scanner.next_token
      if @variables[current_token.value] == nil
        # returns an error message if it is not
        return "Error: The variable " + current_token.value.to_s + " is undefined"
      else
        # returns the value of the variable
        return @variables[current_token.value]
      end
    when "number"
      # return the numeric value of a number
      @scanner.next_token
      return current_token.value
    when "("
      # skips the parentheses and evaluate the expression in the middle
      @scanner.next_token
      result = exp
      @scanner.next_token
      return result
    when "sqrt"
      # skips the sqrt token, the parentheses,
      # and then evaluate the sqrt of the expression
      @scanner.next_token
      @scanner.next_token
      result = Math.sqrt(exp)
      @scanner.next_token
      return result
    when "sin"
      # skips the sin token, the parentheses,
      # and then evaluate the sqrt of the expression
      @scanner.next_token
      @scanner.next_token
      result = Math.sin(exp)
      @scanner.next_token
      return result
    when "cos"
      # skips the cos token, the parentheses,
      # and then evaluate the sqrt of the expression
      @scanner.next_token
      @scanner.next_token
      result = Math.cos(exp)
      @scanner.next_token
      return result
    when "tan"
      # skips the tan token, the parentheses,
      # and then evaluate the sqrt of the expression
      @scanner.next_token
      @scanner.next_token
      result = Math.tan(exp)
      @scanner.next_token
      return result
    end
  end
end

# initialize a new Calculator to run the program
calculator = Calculator.new