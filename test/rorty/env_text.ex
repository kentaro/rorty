defmodule Rorty.Env.Test do
  use ExUnit.Case
  doctest Rorty

  test "put(env, key, value)" do
    env = Rorty.Env.put(%Rorty.Env{}, "foo", 1)
    assert env == %Rorty.Env{vars: %{"foo" => 1}, defs: %{}}
  end

  test "get(env, key)" do
    env = Rorty.Env.put(%Rorty.Env{}, "foo", 1)
    assert Rorty.Env.get(env, "foo") == 1
  end

  test "put_def(env, key, def)" do
    env =
      Rorty.Env.put_def(
        %Rorty.Env{},
        "foo",
        Rorty.Ast.def(
          "foo",
          ["foo", "bar", "baz"],
          Rorty.Ast.block([Rorty.Ast.integer(1)])
        )
      )

    assert env == %Rorty.Env{
             vars: %{},
             defs: %{
               "foo" =>
                 Rorty.Ast.def(
                   "foo",
                   ["foo", "bar", "baz"],
                   Rorty.Ast.block([Rorty.Ast.integer(1)])
                 )
             }
           }
  end

  test "get_def(env, key)" do
    env =
      Rorty.Env.put_def(
        %Rorty.Env{},
        "foo",
        Rorty.Ast.def(
          "foo",
          ["foo", "bar", "baz"],
          Rorty.Ast.block([Rorty.Ast.integer(1)])
        )
      )

    assert Rorty.Env.get_def(env, "foo") ==
             Rorty.Ast.def(
               "foo",
               ["foo", "bar", "baz"],
               Rorty.Ast.block([Rorty.Ast.integer(1)])
             )
  end
end
