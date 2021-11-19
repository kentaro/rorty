defmodule Rorty.Interpreter do
  @doc """
  Interprets and evaluates the given AST.

  ## Examples

      iex> env = %Rorty.Env{}
      iex> Rorty.interpret(Rorty.Ast.add(Rorty.Ast.multiply(Rorty.Ast.integer(3), Rorty.Ast.integer(3)), Rorty.Ast.integer(1)), env)
      {10, env}

  """
  def interpret(exprs, %Rorty.Env{} = env) when is_list(exprs) do
    exprs
    |> Enum.reduce({false, env}, fn expr, acc ->
      {_, env} = acc
      interpret(expr, env)
    end)
  end

  def interpret(%Rorty.Ast.Expr.Binary{} = expr, %Rorty.Env{} = env) do
    {left, env} = interpret(expr.left, env)
    {right, env} = interpret(expr.right, env)

    expr.operator.execute(left, right, env)
  end

  def interpret(%Rorty.Ast.Expr.IntegerLiteral{} = expr, %Rorty.Env{} = env) do
    {expr.value, env}
  end

  def interpret(%Rorty.Ast.Expr.StringLiteral{} = expr, %Rorty.Env{} = env) do
    {expr.value, env}
  end

  def interpret(%Rorty.Ast.Expr.Identifier{} = expr, %Rorty.Env{} = env) do
    value = Rorty.Env.get(env, expr)
    {value, env}
  end

  def interpret(%Rorty.Ast.Expr.Boolean{} = expr, %Rorty.Env{} = env) do
    {expr.value, env}
  end

  def interpret(%Rorty.Ast.Expr.Assignment{} = expr, %Rorty.Env{} = env) do
    {value, env} = interpret(expr.value, env)
    {value, Rorty.Env.put(env, expr.name, value)}
  end

  def interpret(%Rorty.Ast.Expr.Block{} = expr, %Rorty.Env{} = env) do
    expr.exprs
    |> Enum.reduce({0, env}, fn expr, acc ->
      {_, env} = acc
      interpret(expr, env)
    end)
  end

  def interpret(%Rorty.Ast.Expr.If{} = expr, %Rorty.Env{} = env) do
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

  def interpret(%Rorty.Ast.Expr.While{} = expr, %Rorty.Env{} = env) do
    {condition, env} = interpret(expr.condition, env)

    if condition do
      {_, env} = interpret(expr.body, env)
      interpret(expr, env)
    else
      {false, env}
    end
  end

  def interpret(%Rorty.Ast.Expr.Def{} = expr, %Rorty.Env{} = env) do
    env = Rorty.Env.put_def(env, expr.name, expr)
    {false, env}
  end

  def interpret(%Rorty.Ast.Expr.Call{} = expr, %Rorty.Env{} = env) do
    def = resolve_function(env, expr.name)
    call_function(def, expr, env)
  end

  defp resolve_function(env, name) do
    def =
      Rorty.Env.get_def(env, name) ||
        Rorty.Builtins.function_for(name.name)

    unless def do
      raise("no such function: #{name}")
    end

    def
  end

  defp call_function(%Rorty.Ast.Expr.Def{} = def, %Rorty.Ast.Expr.Call{} = caller, env) do
    local_env =
      Enum.zip(def.args || [], caller.args || [])
      |> Enum.reduce(%Rorty.Env{}, fn {name, expr}, acc ->
        {var, _} = interpret(expr, env)
        Rorty.Env.put(acc, name, var)
      end)
      |> Map.put(:defs, env.defs)

    {value, _} = interpret(def.body, local_env)
    {value, env}
  end

  defp call_function([module: module, name: name], %Rorty.Ast.Expr.Call{} = caller, env) do
    args =
      caller.args
      |> Enum.map(&interpret(&1, env))
      |> Enum.map(fn {arg, _} -> arg end)

    {apply(module, name, args), env}
  end
end
