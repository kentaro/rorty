defmodule Rorty.Grammar do
  use Neotomex.ExGrammar

  @root true
  define(:program, "statements")

  define :statements, "statement*" do
    statements when is_list(statements) -> List.flatten(statements)
    statements -> statements
  end

  define(:statement, "<space?> (assignment / def / while / for / if / block / expr) <space?>")

  define :assignment, "identifier <space?> <'='> <space?> expr" do
    [name, value] -> Rorty.Ast.assignment(name, value)
  end

  define :def,
         "<'def'> <space?> identifier <'('> (identifier (<space?> <','> <space?> identifier)*)? <')'> block" do
    [name, nil, body] ->
      Rorty.Ast.def(name, nil, body)

    [name, args, body] ->
      args = List.flatten(args)
      Rorty.Ast.def(name, args, body)
  end

  define :while, "<'while'> <space?> <'('> <space?> expr <space?> <')'> block" do
    [condition, body] ->
      Rorty.Ast.while(condition, body)
  end

  define :for,
         "<'for'> <space?> <'('> <space?> identifier <space?> <'in'> <space?> expr <space?> <'to'> <space?> expr <space?><')'> block" do
    [ident, start, last, body] ->
      [
        Rorty.Ast.assignment(ident, start),
        Rorty.Ast.while(
          Rorty.Ast.less_or_equal(
            Rorty.Ast.identifier(ident.name),
            last
          ),
          %Rorty.Ast.Expr.Block{
            exprs:
              Enum.reverse([
                Rorty.Ast.assignment(
                  Rorty.Ast.identifier(ident.name),
                  Rorty.Ast.add(
                    Rorty.Ast.identifier(ident.name),
                    Rorty.Ast.integer(1)
                  )
                )
                | body.exprs
              ])
          }
        )
      ]
  end

  define :if, "<'if'> <space?> <'('> expr <')'> block (<space?> <'else'> block)?" do
    [condition, then, [otherwise]] ->
      Rorty.Ast.if(condition, then, otherwise)

    [condition, then, nil] ->
      Rorty.Ast.if(condition, then)
  end

  define :block, "<space?> <'{'> <space?> statements <space?> <'}'>" do
    [statements] ->
      Rorty.Ast.block(statements)
  end

  define(:expr, "binary_expr")

  define(:binary_expr, "comparative")

  define :comparative, "additive <space?> comparative_operator <space?> comparative / additive" do
    [left, "<", right] -> Rorty.Ast.less_than(left, right)
    [left, "<=", right] -> Rorty.Ast.less_or_equal(left, right)
    [left, ">", right] -> Rorty.Ast.greater_than(left, right)
    [left, ">=", right] -> Rorty.Ast.greater_or_equal(left, right)
    [left, "==", right] -> Rorty.Ast.equal(left, right)
    [left, "!=", right] -> Rorty.Ast.not_equal(left, right)
    primary -> primary
  end

  define :additive, "multitive <space?> additive_operator <space?> additive / multitive" do
    [left, "+", right] -> Rorty.Ast.add(left, right)
    [left, "-", right] -> Rorty.Ast.subtract(left, right)
    primary -> primary
  end

  define :multitive, "primary <space?> multitive_operator <space?> multitive / primary" do
    [left, "*", right] -> Rorty.Ast.multiply(left, right)
    [left, "/", right] -> Rorty.Ast.divide(left, right)
    [left, "%", right] -> Rorty.Ast.mod(left, right)
    primary -> primary
  end

  define(:comparative_operator, "'<=' / '<' / '>=' / '>' / '==' / '!='")

  define(:additive_operator, "'+' / '-'")

  define(:multitive_operator, "'*' / '/' / '%'")

  define(:primary, "<'('> expr <')'> / call / string / number / boolean / identifier")

  define :call, "identifier <'('> (expr (<space?> <','> <space?> expr)*)? <')'> <space?>" do
    [name, nil] ->
      Rorty.Ast.call(name, nil)

    [name, args] ->
      args = List.flatten(args)
      Rorty.Ast.call(name, args)
  end

  define :identifier, "[a-zA-Z_]+[a-zA-Z0-9_]*" do
    chars ->
      Enum.join(chars)
      |> Rorty.Ast.identifier()
  end

  define :string, "<'\"'> (<!'\"'> ('\\\\' / '\\\"' / .))* <'\"'>" do
    [chars] -> Rorty.Ast.string(Enum.join(for [c] <- chars, do: c))
  end

  define :boolean, "'true' / 'false'" do
    "true" -> Rorty.Ast.boolean(true)
    "false" -> Rorty.Ast.boolean(false)
  end

  define :number, "[0-9]+" do
    digits ->
      Enum.join(digits)
      |> String.to_integer()
      |> Rorty.Ast.integer()
  end

  define(:space, "[ \\r\\n\\s\\t]*")
  define(:line_break, "[\\r\\n]*")
end
