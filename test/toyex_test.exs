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

    test "identifier expression" do
      env = %Toyex.Env{vars: %{"foo" => 10}}
      ast = Toyex.Ast.identifier("foo")

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 10
    end

    test "assignment expression" do
      env = %Toyex.Env{}
      ast = Toyex.Ast.assignment("foo", Toyex.Ast.integer(10))

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 10
    end

    test "block expression" do
      env = %Toyex.Env{}
      ast = Toyex.Ast.block([
        Toyex.Ast.assignment("foo", Toyex.Ast.integer(10)),
        Toyex.Ast.add(
          Toyex.Ast.identifier("foo"),
          Toyex.Ast.integer(3)
        )
      ])

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 13
    end

    test "if expression with an else clause when the condition is true" do
      env = %Toyex.Env{}
      ast = Toyex.Ast.if(
        Toyex.Ast.equal(Toyex.Ast.integer(1), Toyex.Ast.integer(1)),
        Toyex.Ast.block([Toyex.Ast.integer(100)]),
        Toyex.Ast.block([Toyex.Ast.integer(99)])
      )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 100
    end

    test "if expression with an else clause when the condition is false" do
      env = %Toyex.Env{}
      ast = Toyex.Ast.if(
        Toyex.Ast.equal(Toyex.Ast.integer(1), Toyex.Ast.integer(0)),
        Toyex.Ast.block([Toyex.Ast.integer(100)]),
        Toyex.Ast.block([Toyex.Ast.integer(99)])
      )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 99
    end

    test "if expression without an else clause when the condition is true" do
      env = %Toyex.Env{}
      ast = Toyex.Ast.if(
        Toyex.Ast.equal(Toyex.Ast.integer(1), Toyex.Ast.integer(1)),
        Toyex.Ast.block([Toyex.Ast.integer(100)])
      )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 100
    end

    test "if expression without an else clause when the condition is false" do
      env = %Toyex.Env{}
      ast = Toyex.Ast.if(
        Toyex.Ast.equal(Toyex.Ast.integer(1), Toyex.Ast.integer(0)),
        Toyex.Ast.block([Toyex.Ast.integer(100)])
      )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 0
    end

    test "while expression" do
      env = %Toyex.Env{vars: %{"foo" => 10}}
      ast = Toyex.Ast.while(
        Toyex.Ast.greater_than(Toyex.Ast.identifier("foo"), Toyex.Ast.integer(0)),
        Toyex.Ast.block([
          Toyex.Ast.assignment(
            "foo",
            Toyex.Ast.subtract(
              Toyex.Ast.identifier("foo"),
              Toyex.Ast.integer(1)
            )
          )
        ])
      )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 0
    end
  end
end
