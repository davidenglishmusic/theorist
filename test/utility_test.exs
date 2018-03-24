defmodule UtilityTest do
  use ExUnit.Case
  doctest Utility

  test "identifies an unknown chord as a cluster" do
    assert Utility.permutations([0, 9, 10]) == [
             [0, 9, 10],
             [0, 10, 9],
             [9, 0, 10],
             [9, 10, 0],
             [10, 0, 9],
             [10, 9, 0]
           ]
  end
end
