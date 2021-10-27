defmodule ToyexTest do
  use ExUnit.Case
  doctest Toyex

  test "put(env, key, value)" do
    env = Toyex.Env.put(%Toyex.Env{}, "foo", 1)
    assert env == %Toyex.Env{vars: %{"foo" => 1}}
  end

  test "get(env, key)" do
    env = Toyex.Env.put(%Toyex.Env{}, "foo", 1)
    assert Toyex.Env.get(env, "foo") == 1
  end
end
