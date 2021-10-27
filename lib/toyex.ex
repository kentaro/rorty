defmodule Toyex do
  @moduledoc """
  Documentation for `Toyex`.
  """

  @doc """
  Interprets and evaluates the given AST.

  ## Examples

      iex> env = %Toyex.Env{}
      iex> Toyex.interpret(Toyex.Ast.add(Toyex.Ast.multiply(Toyex.Ast.integer(3), Toyex.Ast.integer(3)), Toyex.Ast.integer(1)), env)
      {10, env}

  """
  def interpret(%Toyex.Ast.Expression.Binary{} = expr, %Toyex.Env{} = env) do
    {left, env} = interpret(expr.left, env)
    {right, env} = interpret(expr.right, env)

    case expr.operator do
      Toyex.Operator.Add ->
        {left + right, env}

      Toyex.Operator.Divide ->
        {left / right, env}

      Toyex.Operator.Multiply ->
        {left * right, env}

      Toyex.Operator.Subtract ->
        {left - right, env}
    end
  end

  def interpret(%Toyex.Ast.Expression.IntegerLiteral{} = expr, %Toyex.Env{} = env) do
    {expr.value, env}
  end

  def interpret(%Toyex.Ast.Expression.Identifier{} = expr, %Toyex.Env{} = env) do
    {Toyex.Env.get(env, expr.name), env}
  end

  def interpret(%Toyex.Ast.Expression.Assignment{} = expr, %Toyex.Env{} = env) do
    {value, env} = interpret(expr.value, env)
    {value, Toyex.Env.put(env, expr.name, value)}
  end
end
