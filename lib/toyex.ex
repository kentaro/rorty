defmodule Toyex do
  @moduledoc """
  Documentation for `Toyex`.
  """

  @doc """
  Interprets and evaluates the given AST.

  ## Examples

      iex> Toyex.interpret(Toyex.Ast.add(Toyex.Ast.multiply(Toyex.Ast.integer(3), Toyex.Ast.integer(3)), Toyex.Ast.integer(1)))
      10

  """
  def interpret(%Toyex.Ast.Expression.Binary{} = expr) do
    case expr.operator do
      Toyex.Operator.Add ->
        interpret(expr.left) + interpret(expr.right)

      Toyex.Operator.Divide ->
        interpret(expr.left) / interpret(expr.right)

      Toyex.Operator.Multiply ->
        interpret(expr.left) * interpret(expr.right)

      Toyex.Operator.Subtract ->
        interpret(expr.left) - interpret(expr.right)
    end
  end

  def interpret(%Toyex.Ast.Expression.IntegerLiteral{} = expr) do
    expr.value
  end
end
