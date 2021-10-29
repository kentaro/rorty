defmodule Toyex.Grammar do
  use Neotomex.ExGrammar

  @root true
  define :additive, "multitive <'+'> additive / multitive" do
    int when is_struct(int, Toyex.Ast.Expr.IntegerLiteral) -> int
    [x, y] -> Toyex.Ast.add(x, y)
  end

  define :multitive, "primary <'*'> multitive / primary" do
    int when is_struct(int, Toyex.Ast.Expr.IntegerLiteral) -> int
    [x, y] -> Toyex.Ast.multiply(x, y)
  end

  define :primary, "(<'('> additive <')'>) / decimal" do
    int when is_struct(int, Toyex.Ast.Expr.IntegerLiteral) -> int
    [additive] -> additive
  end

  define :decimal, "[0-9]+" do
    digits ->
      Enum.join(digits)
      |> String.to_integer()
      |> Toyex.Ast.integer()
  end

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
