defmodule Toyex.Grammar do
  use Neotomex.ExGrammar

  @root true
  define :program, "statements"

  define :statements, "statement*"

  define :statement, "puts / assignment / def / while / if / block / expr"

  define :puts, "<'puts'> <space?> <'('> expr <')'>" do
    [args] -> IO.puts(args)
  end

  define :assignment, "identifier <space?> <'='> <space?> expr" do
    [name, value] -> Toyex.Ast.assignment(name, value)
  end

  define :def, "<'def'> <space?> identifier <'('> (identifier (<space?> <','> <space?> identifier)*)? <')'> block" do
    [name, args, body] ->
      args = List.flatten(args)
      Toyex.Ast.def(name, args, body)
  end

  define :while, "<'while'> <space?> <'('> expr <')'> block" do
    [condition, body] ->
      Toyex.Ast.while(condition, body)
  end

  define :if, "<'if'> <space?> <'('> expr <')'> block (<'else'> block)?" do
    [condition, then, otherwise] ->
      Toyex.Ast.if(condition, then, otherwise)

    [condition, then] ->
      Toyex.Ast.if(condition, then)
  end

  define :block, "<space?> <'{'> <space?> statements <space?> <'}'> <space?>" do
    [statements] ->
      Toyex.Ast.block(statements)
  end

  define :expr, "binary_expr"

  define :binary_expr, "primary <space?> binary_operator <space?> binary_expr / primary" do
    [left, "<", right] -> Toyex.Ast.less_than(left, right)
    [left, "<=", right] -> Toyex.Ast.less_or_equal(left, right)
    [left, ">", right] -> Toyex.Ast.greater_than(left, right)
    [left, ">=", right] -> Toyex.Ast.greater_or_equal(left, right)
    [left, "==", right] -> Toyex.Ast.equal(left, right)
    [left, "!=", right] -> Toyex.Ast.not_equal(left, right)
    [left, "+", right] -> Toyex.Ast.add(left, right)
    [left, "-", right] -> Toyex.Ast.subtract(left, right)
    [left, "*", right] -> Toyex.Ast.multiply(left, right)
    [left, "/", right] -> Toyex.Ast.divide(left, right)
    integer -> integer
  end

  define(:binary_operator, "'<' / '<=' / '>' / '>=' / '==' / '!=' / '+' / '-' / '*' / '/'")

  define :primary, "<'('> expr <')'> / call / decimal / identifier"

  define :call, "identifier <'('> (expr (<','> expr)*)? <')'>" do
    [name, args] ->
      args = List.flatten(args)
      Toyex.Ast.call(name, args)
  end

  define :identifier, "[a-zA-Z_]+[a-zA-Z0-9_]*" do
    chars ->
      Enum.join(chars)
      |> Toyex.Ast.identifier()
  end

  define :decimal, "[0-9]+" do
    digits ->
      Enum.join(digits)
      |> String.to_integer()
      |> Toyex.Ast.integer()
  end

  define(:space, "[ \\r\\n\\s\\t]*")

  def repl do
    input = IO.gets("Enter an equation: ")

    case input |> String.trim() |> parse() do
      {:ok, result} ->
        IO.inspect(result)

      :mismatch ->
        IO.inspect("You sure you got that right?")
    end

    repl()
  end
end
