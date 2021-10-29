defmodule Toyex.Grammar do
  use Neotomex.ExGrammar

  @root true
  define :additive, "multitive <spacing?> <'+'> <spacing?> additive / multitive" do
    [x, y] -> Toyex.Ast.add(x, y)
    x -> x
  end

  define :multitive, "primary <spacing?> <'*'> <spacing?> multitive / primary" do
    [x, y] -> Toyex.Ast.multiply(x, y)
    x -> x
  end

  define :primary, "(<'('> <spacing?> additive <spacing?> <')'>) / decimal"

  define :decimal, "[0-9]+" do
    digits ->
      Enum.join(digits)
      |> String.to_integer()
      |> Toyex.Ast.integer()
  end

  define :spacing, "[ \\r\\n\\s\\t]*"

  def repl do
    input = IO.gets("Enter an equation: ")

    case input |> String.trim() |> parse() do
      {:ok, result} ->
        IO.puts("Result: #{result}")

      :mismatch ->
        IO.puts("You sure you got that right?")
    end

    repl()
  end
end
