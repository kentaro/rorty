defmodule RortyTest do
  use ExUnit.Case
  doctest Rorty

  describe "run()" do
    test "simple code" do
      assert Rorty.run("1 + 1") == 2
    end
  end

  describe "run_from_file()" do
    test "simple code" do
      assert Rorty.run_from_file("test/assets/test.rorty") == 2
    end
  end
end
