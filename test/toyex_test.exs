defmodule ToyexTest do
  use ExUnit.Case
  doctest Toyex

  test "interpret()" do
    ast =
      Toyex.Ast.add(
        Toyex.Ast.multiply(
          Toyex.Ast.integer(3),
          Toyex.Ast.integer(3)
        ),
        Toyex.Ast.integer(1)
      )

    assert Toyex.interpret(ast) == 10
  end
end
