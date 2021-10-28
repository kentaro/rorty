defmodule Toyex.Env do
  defstruct [:vars, :defs]
  @type key :: String.t()
  @type value :: integer()
  @type def :: Toyex.Ast.Expr.Def.t()
  @type env :: Toyex.Env.t()
  @type vars :: Map.t()
  @type defs :: Map.t()
  @type t :: %Toyex.Env{
          vars: vars,
          defs: defs
        }

  @spec put(Toyex.Env.t(), key, value) :: env
  def put(env, key, value) do
    %Toyex.Env{
      vars: Map.put(env.vars || %{}, key, value),
      defs: env.defs || %{}
    }
  end

  @spec get(Toyex.Env.t(), key) :: value | none()
  def get(env, key) do
    Map.get(env.vars || %{}, key)
  end

  @spec put_def(Toyex.Env.t(), key, def) :: env
  def put_def(env, key, def) do
    %Toyex.Env{
      vars: env.vars || %{},
      defs: Map.put(env.defs || %{}, key, def)
    }
  end

  @spec get_def(Toyex.Env.t(), key) :: def | none()
  def get_def(env, key) do
    Map.get(env.defs || %{}, key)
  end
end
