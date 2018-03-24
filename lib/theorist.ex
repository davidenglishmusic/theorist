require Utility

defmodule Theorist do
  @pitch_mapping %{
    "c" => 0,
    "c_sharp" => 1,
    "d_flat" => 1,
    "d" => 2,
    "d_sharp" => 3,
    "e_flat" => 3,
    "e" => 4,
    "f_flat" => 4,
    "e_sharp" => 5,
    "f" => 5,
    "f_sharp" => 6,
    "g_flat" => 6,
    "g" => 7,
    "g_sharp" => 8,
    "a_flat" => 8,
    "a" => 9,
    "a_sharp" => 10,
    "b_flat" => 10,
    "b" => 11,
    "c_flat" => 11,
    "b_sharp" => 0
  }

  @diad_mapping %{
    [0] => :unison,
    [1] => :minor_second,
    [2] => :major_second,
    [3] => :minor_third,
    [4] => :major_third,
    [5] => :perfect_fourth,
    [6] => :tritone,
    [7] => :perfect_fifth,
    [8] => :minor_sixth,
    [9] => :major_sixth,
    [10] => :minor_seventh,
    [11] => :major_seventh
  }

  @triad_mapping %{
    [4, 7] => :major_triad,
    [3, 7] => :minor_triad,
    [3, 6] => :diminished_triad,
    [4, 8] => :augmented_triad
  }

  @seventh_mapping %{
    [4, 7, 11] => :major_seventh,
    [4, 7, 10] => :dominant_seventh,
    [3, 7, 10] => :minor_seventh,
    [3, 6, 10] => :half_diminished,
    [3, 6, 9] => :diminished_seventh
  }

  @octave_number 12

  def pitch_to_number(lettered_pitch) do
    @pitch_mapping[lettered_pitch]
  end

  def identify_from_intervals(intervals) do
    case length(intervals) do
      0 -> :unison
      1 -> identify_chord(@diad_mapping[intervals])
      2 -> identify_chord(@triad_mapping[intervals])
      3 -> identify_chord(@seventh_mapping[intervals])
      _ -> :cluster
    end
  end

  defp identify_chord(mapping_result) do
    if mapping_result == nil, do: :cluster, else: mapping_result
  end

  def absolute_interval(pitch_a, pitch_b) do
    if absolute_pitch_number(pitch_a) - absolute_pitch_number(pitch_b) >= 0 do
      absolute_pitch_number(pitch_a) - absolute_pitch_number(pitch_b)
    else
      absolute_pitch_number(pitch_b) - absolute_pitch_number(pitch_a)
    end
  end

  def absolute_pitch_number(pitch) do
    pitch.number + pitch.octave * 12
  end

  def stack_pitch_numbers(pitch_numbers) do
    do_stack_pitch_numbers(pitch_numbers, 0)
  end

  defp do_stack_pitch_numbers([head | tail], current_offset) do
    next_offset =
      if head > List.first(tail), do: current_offset + @octave_number, else: current_offset

    [head + current_offset | do_stack_pitch_numbers(tail, next_offset)]
  end

  defp do_stack_pitch_numbers([], _current_offset), do: []
end
