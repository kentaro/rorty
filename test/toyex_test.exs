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
end
