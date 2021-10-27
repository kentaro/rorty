defmodule ToyexTest do
  use ExUnit.Case
  doctest Toyex

  describe "interpret()" do
    test "binary expression" do
      env = %Toyex.Env{}

      ast =
        Toyex.Ast.add(
          Toyex.Ast.multiply(
            Toyex.Ast.integer(3),
            Toyex.Ast.integer(3)
          ),
          Toyex.Ast.integer(1)
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 10
    end

    test "identifier" do
      env = %Toyex.Env{vars: %{"foo" => 10}}
      ast = Toyex.Ast.identifier("foo")

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 10
    end

    test "assignment" do
      env = %Toyex.Env{}
      ast = Toyex.Ast.assignment("foo", Toyex.Ast.integer(10))

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 10
    end
  end
end
