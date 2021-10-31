defmodule ToyexTest do
  use ExUnit.Case
  doctest Toyex

  describe "run()" do
    test "simple code" do
      assert Toyex.run("1 + 1") == 2
    end
  end

  describe "run_from_file()" do
    test "simple code" do
      assert Toyex.run_from_file("test/assets/test.toyex") == 2
    end
  end
end
