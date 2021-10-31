defmodule ToyexTest do
  use ExUnit.Case
  doctest Toyex

  describe "run()" do
    test "simple code" do
      assert Toyex.run("1 + 1") == 2
    end
  end

  describe "interpret()" do
    test "multiple expressions" do
      env = %Toyex.Env{}

      ast = [
        Toyex.Ast.assignment(
          "foo",
          Toyex.Ast.integer(3)
        ),
        Toyex.Ast.add(
          Toyex.Ast.multiply(
            Toyex.Ast.identifier("foo"),
            Toyex.Ast.integer(3)
          ),
          Toyex.Ast.integer(1)
        )
      ]

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 10
    end

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

      ast =
        Toyex.Ast.block([
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

      ast =
        Toyex.Ast.if(
          Toyex.Ast.equal(Toyex.Ast.integer(1), Toyex.Ast.integer(1)),
          Toyex.Ast.block([Toyex.Ast.integer(100)]),
          Toyex.Ast.block([Toyex.Ast.integer(99)])
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 100
    end

    test "if expression with an else clause when the condition is false" do
      env = %Toyex.Env{}

      ast =
        Toyex.Ast.if(
          Toyex.Ast.equal(Toyex.Ast.integer(1), Toyex.Ast.integer(0)),
          Toyex.Ast.block([Toyex.Ast.integer(100)]),
          Toyex.Ast.block([Toyex.Ast.integer(99)])
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 99
    end

    test "if expression without an else clause when the condition is true" do
      env = %Toyex.Env{}

      ast =
        Toyex.Ast.if(
          Toyex.Ast.equal(Toyex.Ast.integer(1), Toyex.Ast.integer(1)),
          Toyex.Ast.block([Toyex.Ast.integer(100)])
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 100
    end

    test "if expression without an else clause when the condition is false" do
      env = %Toyex.Env{}

      ast =
        Toyex.Ast.if(
          Toyex.Ast.equal(Toyex.Ast.integer(1), Toyex.Ast.integer(0)),
          Toyex.Ast.block([Toyex.Ast.integer(100)])
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 0
    end

    test "while expression" do
      env = %Toyex.Env{vars: %{"foo" => 10}}

      ast =
        Toyex.Ast.while(
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

    test "def expression" do
      env = %Toyex.Env{}

      def =
        Toyex.Ast.def(
          "foo",
          ["foo", "bar", "baz"],
          Toyex.Ast.block([Toyex.Ast.integer(1)])
        )

      ast = def

      {result, env} = Toyex.interpret(ast, env)
      assert result == 0
      assert Toyex.Env.get_def(env, "foo") == def
    end

    test "call expression" do
      env = %Toyex.Env{vars: %{"a" => 1, "b" => 2}}

      def =
        Toyex.Ast.def(
          "foo",
          ["a", "b"],
          Toyex.Ast.block([
            Toyex.Ast.add(
              Toyex.Ast.identifier("a"),
              Toyex.Ast.identifier("b")
            )
          ])
        )

      ast =
        Toyex.Ast.block([
          def,
          Toyex.Ast.call("foo", [
            Toyex.Ast.integer(3),
            Toyex.Ast.integer(4)
          ])
        ])

      {result, env} = Toyex.interpret(ast, env)
      assert result == 7

      assert env == %Toyex.Env{
               vars: %{"a" => 1, "b" => 2},
               defs: %{"foo" => def}
             }
    end
  end
end
