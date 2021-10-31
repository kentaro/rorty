defmodule Toyex.Grammar do
  use Neotomex.ExGrammar

  @root true
  define(:program, "statements")

  define :statements, "statement*" do
    statements when is_list(statements) -> List.flatten(statements)
    statements -> statements
  end

  define(:statement, "<space?> (assignment / def / while / if / block / expr) <space?>")

  define :assignment, "identifier <space?> <'='> <space?> expr" do
    [name, value] -> Toyex.Ast.assignment(name, value)
  end

  define :def,
         "<'def'> <space?> identifier <'('> (identifier (<space?> <','> <space?> identifier)*)? <')'> block" do
    [name, nil, body] ->
      Toyex.Ast.def(name, nil, body)

    [name, args, body] ->
      args = List.flatten(args)
      Toyex.Ast.def(name, args, body)
  end

  define :while, "<'while'> <space?> <'('> expr <')'> block" do
    [condition, body] ->
      Toyex.Ast.while(condition, body)
  end

  define :if, "<'if'> <space?> <'('> expr <')'> block (<space?> <'else'> block)?" do
    [condition, then, [otherwise]] ->
      Toyex.Ast.if(condition, then, otherwise)

    [condition, then, nil] ->
      Toyex.Ast.if(condition, then)
  end

  define :block, "<space?> <'{'> <space?> statements <space?> <'}'>" do
    [statements] ->
      Toyex.Ast.block(statements)
  end

  define(:expr, "binary_expr")

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
    primary -> primary
  end

  define(:binary_operator, "'<=' / '<' / '>=' / '>' / '==' / '!=' / '+' / '-' / '*' / '/'")

  define(:primary, "<'('> expr <')'> / call / string / number / boolean / identifier")

  define :call, "identifier <'('> (expr (<','> expr)*)? <')'> <space?>" do
    [name, nil] ->
      Toyex.Ast.call(name, nil)

    [name, args] ->
      args = List.flatten(args)
      Toyex.Ast.call(name, args)
  end

  define :identifier, "[a-zA-Z_]+[a-zA-Z0-9_]*" do
    chars ->
      Enum.join(chars)
      |> Toyex.Ast.identifier()
  end

  define :string, "<'\"'> (<!'\"'> ('\\\\' / '\\\"' / .))* <'\"'>" do
    [chars] -> Toyex.Ast.string(Enum.join(for [c] <- chars, do: c))
  end

  define :boolean, "'true' / 'false'" do
    "true" -> Toyex.Ast.boolean(true)
    "false" -> Toyex.Ast.boolean(false)
  end

  define :number, "[0-9]+" do
    digits ->
      Enum.join(digits)
      |> String.to_integer()
      |> Toyex.Ast.integer()
  end

  define(:space, "[ \\r\\n\\s\\t]*")
  define(:line_break, "[\\r\\n]*")

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
