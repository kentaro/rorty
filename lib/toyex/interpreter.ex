defmodule Toyex.Interpreter do
  @doc """
  Interprets and evaluates the given AST.

  ## Examples

      iex> env = %Toyex.Env{}
      iex> Toyex.interpret(Toyex.Ast.add(Toyex.Ast.multiply(Toyex.Ast.integer(3), Toyex.Ast.integer(3)), Toyex.Ast.integer(1)), env)
      {10, env}

  """
  def interpret(exprs, %Toyex.Env{} = env) when is_list(exprs) do
    exprs
    |> Enum.reduce({0, env}, fn expr, acc ->
      {_, env} = acc
      interpret(expr, env)
    end)
  end

  def interpret(%Toyex.Ast.Expr.Binary{} = expr, %Toyex.Env{} = env) do
    {left, env} = interpret(expr.left, env)
    {right, env} = interpret(expr.right, env)

    expr.operator.execute(left, right, env)
  end

  def interpret(%Toyex.Ast.Expr.IntegerLiteral{} = expr, %Toyex.Env{} = env) do
    {expr.value, env}
  end

  def interpret(%Toyex.Ast.Expr.StringLiteral{} = expr, %Toyex.Env{} = env) do
    {expr.value, env}
  end

  def interpret(%Toyex.Ast.Expr.Identifier{} = expr, %Toyex.Env{} = env) do
    value = Toyex.Env.get(env, expr)
    {value, env}
  end

  def interpret(%Toyex.Ast.Expr.Boolean{} = expr, %Toyex.Env{} = env) do
    {expr.value, env}
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

    if condition do
      interpret(expr.then, env)
    else
      if expr.otherwise do
        interpret(expr.otherwise, env)
      else
        {false, env}
      end
    end
  end

  def interpret(%Toyex.Ast.Expr.While{} = expr, %Toyex.Env{} = env) do
    {condition, env} = interpret(expr.condition, env)

    if condition do
      {_, env} = interpret(expr.body, env)
      interpret(expr, env)
    else
      {false, env}
    end
  end

  def interpret(%Toyex.Ast.Expr.Def{} = expr, %Toyex.Env{} = env) do
    env = Toyex.Env.put_def(env, expr.name, expr)
    {false, env}
  end

  def interpret(%Toyex.Ast.Expr.Call{} = expr, %Toyex.Env{} = env) do
    def = Toyex.Env.get_def(env, expr.name)

    unless def do
      raise("no such function: #{expr.name}")
    end

    local_env =
      Enum.zip(def.args, expr.args)
      |> Enum.reduce(%Toyex.Env{}, fn {name, expr}, acc ->
        {var, _} = interpret(expr, env)
        Toyex.Env.put(acc, name, var)
      end)
      |> Map.put(:defs, env.defs)

    {value, _} = interpret(def.body, local_env)
    {value, env}
  end
end
