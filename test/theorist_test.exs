defmodule TheoristTest do
  use ExUnit.Case
  doctest Theorist

  test "identifies an unknown chord as a cluster" do
    assert Theorist.identify_from_intervals([0, 9, 10]) == :cluster
  end

  test "identifies a major chord accordingly" do
    assert Theorist.identify_from_intervals([4, 7]) == :major_triad
  end

  test "identifies a minor chord accordingly" do
    assert Theorist.identify_from_intervals([3, 7]) == :minor_triad
  end

  test "identifies a single pitch as a unison" do
    assert Theorist.identify_from_intervals([]) == :unison
  end

  test "identifies a perfect fifth accordingly" do
    assert Theorist.identify_from_intervals([7]) == :perfect_fifth
  end

  test "converts a pitch to the correct number" do
    assert Theorist.pitch_to_number("a_flat") == 8
  end

  test "converts a pitch to the correct absolute_pitch_number" do
    assert Theorist.absolute_pitch_number(%Pitch{number: 0, octave: 0}) == 0
    assert Theorist.absolute_pitch_number(%Pitch{number: 0, octave: 1}) == 12
    assert Theorist.absolute_pitch_number(%Pitch{number: 2, octave: 4}) == 50
  end

  test "obtains the absolute interval between two pitches" do
    assert Theorist.absolute_interval(%Pitch{number: 0, octave: 0}, %Pitch{number: 5, octave: 1}) ==
             17

    assert Theorist.absolute_interval(%Pitch{number: 4, octave: 5}, %Pitch{number: 1, octave: 5}) ==
             3
  end

  test "stack_pitch_numbers" do
    assert Theorist.stack_pitch_numbers([2, 6, 9]) == [2, 6, 9]
    assert Theorist.stack_pitch_numbers([6, 2, 9]) == [6, 14, 21]
    assert Theorist.stack_pitch_numbers([11, 5, 1]) == [11, 17, 25]
    assert Theorist.stack_pitch_numbers([11, 1, 3]) == [11, 13, 15]
  end
end
