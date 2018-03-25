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

  test "stacks pitch numbers relative to the first" do
    d_zero = %Pitch{number: 2, octave: 0}
    f_sharp_zero = %Pitch{number: 6, octave: 0}
    a_zero = %Pitch{number: 9, octave: 0}

    test_a_absolutes =
      Enum.map(Theorist.stack_pitches_relatively([d_zero, f_sharp_zero, a_zero]), fn pitch ->
        Theorist.absolute_pitch_number(pitch)
      end)

    assert test_a_absolutes == [2, 6, 9]

    test_b_absolutes =
      Enum.map(Theorist.stack_pitches_relatively([f_sharp_zero, d_zero, a_zero]), fn pitch ->
        Theorist.absolute_pitch_number(pitch)
      end)

    assert test_b_absolutes == [6, 14, 21]

    b_zero = %Pitch{number: 11, octave: 0}
    f_zero = %Pitch{number: 5, octave: 0}
    c_sharp_zero = %Pitch{number: 1, octave: 0}

    test_c_absolutes =
      Enum.map(Theorist.stack_pitches_relatively([b_zero, f_zero, c_sharp_zero]), fn pitch ->
        Theorist.absolute_pitch_number(pitch)
      end)

    assert test_c_absolutes == [11, 17, 25]
  end
end
