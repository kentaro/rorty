defmodule Toyex.Env do
  defstruct [:vars]
  @type key :: String.t()
  @type value :: integer()
  @type vars :: Map.t()
  @type t :: %Toyex.Env{vars: vars}

  @spec put(Toyex.Env.t(), key, value) :: Toyex.Env.t()
  def put(env, key, value) do
    %Toyex.Env{
      vars: Map.put(env.vars || %{}, key, value)
    }
  end

  @spec get(Toyex.Env.t(), key) :: value
  def get(env, key) do
    Map.get(env.vars || %{}, key)
  end
end
