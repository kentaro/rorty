defmodule Toyex.Env.Test do
  use ExUnit.Case
  doctest Toyex

  test "put(env, key, value)" do
    env = Toyex.Env.put(%Toyex.Env{}, "foo", 1)
    assert env == %Toyex.Env{vars: %{"foo" => 1}, defs: %{}}
  end

  test "get(env, key)" do
    env = Toyex.Env.put(%Toyex.Env{}, "foo", 1)
    assert Toyex.Env.get(env, "foo") == 1
  end

  test "put_def(env, key, def)" do
    env =
      Toyex.Env.put_def(
        %Toyex.Env{},
        "foo",
        Toyex.Ast.def(
          "foo",
          ["foo", "bar", "baz"],
          Toyex.Ast.block([Toyex.Ast.integer(1)])
        )
      )

    assert env == %Toyex.Env{
             vars: %{},
             defs: %{
               "foo" =>
                 Toyex.Ast.def(
                   "foo",
                   ["foo", "bar", "baz"],
                   Toyex.Ast.block([Toyex.Ast.integer(1)])
                 )
             }
           }
  end

  test "get_def(env, key)" do
    env =
      Toyex.Env.put_def(
        %Toyex.Env{},
        "foo",
        Toyex.Ast.def(
          "foo",
          ["foo", "bar", "baz"],
          Toyex.Ast.block([Toyex.Ast.integer(1)])
        )
      )

    assert Toyex.Env.get_def(env, "foo") ==
             Toyex.Ast.def(
               "foo",
               ["foo", "bar", "baz"],
               Toyex.Ast.block([Toyex.Ast.integer(1)])
             )
  end
end
