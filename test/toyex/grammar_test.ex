defmodule Toyex.Grammar.Test do
  use ExUnit.Case
  doctest Toyex

  import Toyex.{Ast, Grammar}

  describe "statements" do
    test "single line with an expression" do
      src = """
      1
      """

      {:ok, ast} = parse(src)
      assert ast == [integer(1)]
    end

    test "single line with a statement" do
      src = """
      a = 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               assignment(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "multiple lines" do
      src = """
      a = 1
      a
      """

      {:ok, ast} = parse(src)

      assert ast == [
               assignment(
                 identifier("a"),
                 integer(1)
               ),
               identifier("a")
             ]
    end
  end

  describe "assignment" do
    test "single assignment assignment" do
      src = """
      a = 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               assignment(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "multiple assignment statements" do
      src = """
      a = 1
      b = a
      """

      {:ok, ast} = parse(src)

      assert ast == [
               assignment(
                 identifier("a"),
                 integer(1)
               ),
               assignment(
                 identifier("b"),
                 identifier("a")
               )
             ]
    end
  end

  describe "def" do
    test "single def statement" do
      src = """
      def foo(a, b) {
        a = b
      }
      """

      {:ok, ast} = parse(src)

      assert ast == [
               def(
                 identifier("foo"),
                 [identifier("a"), identifier("b")],
                 block([
                   assignment(
                     identifier("a"),
                     identifier("b")
                   )
                 ])
               )
             ]
    end
  end

  describe "while" do
    test "single while statement" do
      src = """
      while (a < 10) {
        a = a + 1
      }
      """

      {:ok, ast} = parse(src)

      assert ast == [
               while(
                 less_than(
                   identifier("a"),
                   integer(10)
                 ),
                 block([
                   assignment(
                     identifier("a"),
                     add(
                       identifier("a"),
                       integer(1)
                     )
                   )
                 ])
               )
             ]
    end
  end

  describe "if" do
    test "single if statement with both then and otherwise" do
      src = """
      if (a < 10) {
        b = 1
      } else {
        b = 2
      }
      """

      {:ok, ast} = parse(src)

      assert ast == [
               Toyex.Ast.if(
                 less_than(
                   identifier("a"),
                   integer(10)
                 ),
                 block([
                   assignment(
                     identifier("b"),
                     integer(1)
                   )
                 ]),
                 block([
                   assignment(
                     identifier("b"),
                     integer(2)
                   )
                 ])
               )
             ]
    end

    test "single if statement with both then and without otherwise" do
      src = """
      if (a < 10) {
        b = 1
      }
      """

      {:ok, ast} = parse(src)

      assert ast == [
               Toyex.Ast.if(
                 less_than(
                   identifier("a"),
                   integer(10)
                 ),
                 block([
                   assignment(
                     identifier("b"),
                     integer(1)
                   )
                 ])
               )
             ]
    end
  end

  describe "block" do
    test "single block statement" do
      src = """
      {
        a = 1
      }
      """

      {:ok, ast} = parse(src)

      assert ast == [
               block([
                 assignment(
                   identifier("a"),
                   integer(1)
                 )
               ])
             ]
    end
  end

  describe "binary expr" do
    test "less than" do
      src = """
      a < 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               less_than(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "less or equal" do
      src = """
      a <= 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               less_or_equal(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "greater than" do
      src = """
      a > 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               greater_than(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "greater or equal" do
      src = """
      a >= 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               greater_or_equal(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "equal" do
      src = """
      a == 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               equal(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "not equal" do
      src = """
      a != 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               not_equal(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "add" do
      src = """
      a + 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               add(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "subtract" do
      src = """
      a - 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               subtract(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "multiply" do
      src = """
      a * 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               multiply(
                 identifier("a"),
                 integer(1)
               )
             ]
    end

    test "divide" do
      src = """
      a / 1
      """

      {:ok, ast} = parse(src)

      assert ast == [
               divide(
                 identifier("a"),
                 integer(1)
               )
             ]
    end
  end

  describe "primary" do
    test "expr with parens" do
      src = """
      (1 + 1)
      """

      {:ok, ast} = parse(src)

      assert ast == [
               add(
                 integer(1),
                 integer(1)
               )
             ]
    end

    test "call" do
      src = """
      foo(a)
      """

      {:ok, ast} = parse(src)

      assert ast == [
               call(
                 identifier("foo"),
                 [identifier("a")]
               )
             ]
    end

    test "number" do
      src = """
      100
      """

      {:ok, ast} = parse(src)

      assert ast == [
               integer(100)
             ]
    end

    test "identifier" do
      src = """
      a
      """

      {:ok, ast} = parse(src)

      assert ast == [
               identifier("a")
             ]
    end

    test "true" do
      src = """
      true
      """

      {:ok, ast} = parse(src)

      assert ast == [
               boolean(true)
             ]
    end

    test "false" do
      src = """
      false
      """

      {:ok, ast} = parse(src)

      assert ast == [
               boolean(false)
             ]
    end
  end
end
