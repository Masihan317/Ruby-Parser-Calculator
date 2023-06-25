# Copyright (c) 2023. Sihan Ma.
# All rights reserved.

# This file contains 2 ruby classes: Scanner and Token. Scanner reads the
# calculator program from the input stream and breaks the input into tokens.

require "readline"

# Scanner class
class Scanner
  # initializes a new Scanner with the provided input
  def initialize(input)
    @input = input
    @tokens = Array.new
    @index = 0
    parse_token
  end

  # looks at the first element in the Scanner without advancing
  def peek
    @tokens.first
  end

  # looks at the second element in the Scanner without advancing
  def next
    if @tokens.size < 2
      return nil
    end
    return @tokens[1]
  end

  # gets the next token in the Scanner
  def next_token
    @tokens.shift
  end

  # parses the token based on the user input
  def parse_token
    # loop through the input
    while !@input.empty?
      # matches identifiers or keywords
      if /^[a-zA-Z]+[a-zA-Z0-9_]*/.match(@input)
        pattern = /^[a-zA-Z]+[a-zA-Z0-9_]*/
        token_input = pattern.match(@input).to_s
        # the matched part is a keyword
        if /^(list|clear|quit|exit|sqrt|sin|cos|tan)$/.match(token_input)
          pattern = /(list|clear|quit|exit|sqrt|sin|cos|tan)/
          token_input = pattern.match(token_input).to_s
          @tokens << Token.new(token_input, nil)
          @input = @input.sub(pattern, "").strip
        else
          @tokens << Token.new("id", token_input)
          @input = @input.sub(pattern, "").strip
        end
      # matches numbers with exponents and convert to float
      elsif /^[0-9]+\.?[0-9]*[eE][\+-]?[0-9]+/.match(@input)
        pattern = /^[0-9]+\.?[0-9]*[eE][\+-]?[0-9]+/
        token_input = pattern.match(@input).to_s
        @tokens << Token.new("number", token_input.to_f)
        @input = @input.sub(pattern, "").strip
      # matches numbers and convert to float
      elsif /^[0-9]+\.?[0-9]*/.match(@input)
        pattern = /^[0-9]+\.?[0-9]*/
        token_input = pattern.match(@input).to_s
        @tokens << Token.new("number", token_input.to_f)
        @input = @input.sub(pattern, "").strip
      # matches operators
      elsif /^(\+|-|\*\*|\*|\/|=|\(|\))/.match(@input)
        pattern = /^(\+|-|\*\*|\*|\/|=|\(|\))/
        token_input = pattern.match(@input).to_s
        @tokens << Token.new(token_input, nil)
        @input = @input.sub(pattern, "").strip
      # invalid token if not matched in previous cases
      else
        pattern = /./
        @input = @input.sub(pattern, "").strip
        STDERR.puts "There's one invalid token somewhere. Skipping that token."
      end
    end
    # reached the end of the line so returns EOL token
    @tokens << Token.new("EOL", nil)
  end
end

# Token class
class Token
  attr_accessor :kind, :value

  # initializes a new Token
  def initialize(kind, value)
    @kind = kind
    @value = value
  end

  # prints the formatted Token
  def to_s
    if value.nil?
      kind.to_s
    else
      return kind.to_s + ": " + value.to_s
    end
  end
end