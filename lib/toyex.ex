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
  def interpret(%Toyex.Ast.Expr.Binary{} = expr, %Toyex.Env{} = env) do
    {left, env} = interpret(expr.left, env)
    {right, env} = interpret(expr.right, env)

    expr.operator.execute(left, right, env)
  end

  def interpret(%Toyex.Ast.Expr.IntegerLiteral{} = expr, %Toyex.Env{} = env) do
    {expr.value, env}
  end

  def interpret(%Toyex.Ast.Expr.Identifier{} = expr, %Toyex.Env{} = env) do
    {Toyex.Env.get(env, expr.name), env}
  end

  def interpret(%Toyex.Ast.Expr.Assignment{} = expr, %Toyex.Env{} = env) do
    {value, env} = interpret(expr.value, env)
    {value, Toyex.Env.put(env, expr.name, value)}
  end

  def interpret(%Toyex.Ast.Expr.Block{} = expr, %Toyex.Env{} = env) do
    expr.exprs
    |> Enum.reduce({0, env}, fn expr, acc ->
      {_, env} = acc
      interpret(expr, env)
    end)
  end

  def interpret(%Toyex.Ast.Expr.If{} = expr, %Toyex.Env{} = env) do
    {condition, env} = interpret(expr.condition, env)

    if condition != 0 do
      interpret(expr.then, env)
    else
      if expr.otherwise do
        interpret(expr.otherwise, env)
      else
        {0, env}
      end
    end
  end

  def interpret(%Toyex.Ast.Expr.While{} = expr, %Toyex.Env{} = env) do
    {condition, env} = interpret(expr.condition, env)

    if condition != 0 do
      {_, env} = interpret(expr.body, env)
      interpret(expr, env)
    else
      {0, env}
    end
  end

  def interpret(%Toyex.Ast.Expr.Def{} = expr, %Toyex.Env{} = env) do
    env = Toyex.Env.put_def(env, expr.name, expr)
    {0, env}
  end

  def interpret(%Toyex.Ast.Expr.Call{} = expr, %Toyex.Env{} = env) do
    def = Toyex.Env.get_def(env, expr.name)

    unless def do
      raise("no such function: #{expr.name}")
    end

    local_env =
      Enum.zip(def.args, expr.args)
      |> Enum.reduce(%Toyex.Env{}, fn {name, expr}, env ->
        {var, env} = interpret(expr, env)
        Toyex.Env.put(env, name, var)
      end)

    {value, _} = interpret(def.body, local_env)
    {value, env}
  end
end
