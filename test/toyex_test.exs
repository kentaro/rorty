defmodule ToyexTest do
  use ExUnit.Case
  doctest Toyex

  test "greets the world" do
    assert Toyex.hello() == :world
  end
end
