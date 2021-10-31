defmodule ToyexTest do
  use ExUnit.Case
  doctest Toyex

  import Toyex.Ast

  describe "run()" do
    test "simple code" do
      assert Toyex.run("1 + 1") == 2
    end
  end

  describe "run_from_file()" do
    test "simple code" do
      assert Toyex.run_from_file("examples/factorial.toyex") == 120
    end
  end

  describe "interpret()" do
    test "multiple expressions" do
      env = %Toyex.Env{}

      ast = [
        assignment(
          identifier("foo"),
          integer(3)
        ),
        add(
          multiply(
            identifier("foo"),
            integer(3)
          ),
          integer(1)
        )
      ]

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 10
    end

    test "binary expression" do
      env = %Toyex.Env{}

      ast =
        add(
          multiply(
            integer(3),
            integer(3)
          ),
          integer(1)
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 10
    end

    test "identifier expression" do
      env = %Toyex.Env{vars: %{identifier("foo") => 10}}
      ast = identifier("foo")

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 10
    end

    test "assignment expression" do
      env = %Toyex.Env{}
      ast = assignment(identifier("foo"), integer(10))

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 10
    end

    test "block expression" do
      env = %Toyex.Env{}

      ast =
        block([
          assignment(identifier("foo"), integer(10)),
          add(
            identifier("foo"),
            integer(3)
          )
        ])

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 13
    end

    test "if expression with an else clause when the condition is true" do
      env = %Toyex.Env{}

      ast =
        if(
          equal(integer(1), integer(1)),
          block([integer(100)]),
          block([integer(99)])
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 100
    end

    test "if expression with an else clause when the condition is false" do
      env = %Toyex.Env{}

      ast =
        if(
          equal(integer(1), integer(0)),
          block([integer(100)]),
          block([integer(99)])
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 99
    end

    test "if expression without an else clause when the condition is true" do
      env = %Toyex.Env{}

      ast =
        Toyex.Ast.if(
          equal(integer(1), integer(1)),
          block([integer(100)])
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == 100
    end

    test "if expression without an else clause when the condition is false" do
      env = %Toyex.Env{}

      ast =
        Toyex.Ast.if(
          equal(integer(1), integer(0)),
          block([integer(100)])
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == false
    end

    test "while expression" do
      env = %Toyex.Env{vars: %{identifier("foo") => 10}}

      ast =
        while(
          greater_than(
            identifier("foo"),
            integer(0)
          ),
          block([
            assignment(
              identifier("foo"),
              subtract(
                identifier("foo"),
                integer(1)
              )
            )
          ])
        )

      {result, _env} = Toyex.interpret(ast, env)
      assert result == false
    end

    test "def expression" do
      env = %Toyex.Env{}

      def =
        def(
          "foo",
          ["foo", "bar", "baz"],
          block([integer(1)])
        )

      ast = def

      {result, env} = Toyex.interpret(ast, env)
      assert result == false
      assert Toyex.Env.get_def(env, "foo") == def
    end

    test "call expression" do
      env = %Toyex.Env{vars: %{identifier("a") => 1, identifier("b") => 2}}

      def =
        def(
          identifier("foo"),
          [identifier("a"), identifier("b")],
          block([
            add(
              identifier("a"),
              identifier("b")
            )
          ])
        )

      ast =
        block([
          def,
          call(identifier("foo"), [
            integer(3),
            integer(4)
          ])
        ])

      {result, env} = Toyex.interpret(ast, env)
      assert result == 7

      assert env == %Toyex.Env{
               vars: %{identifier("a") => 1, identifier("b") => 2},
               defs: %{identifier("foo") => def}
             }
    end
  end
end
