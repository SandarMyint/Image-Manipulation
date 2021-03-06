defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  def main(input) do
    input 
    |> hash_input
    |> pick_color
    |> built_grid
  end

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello
      :world

  """
  def hash_input(input) do
    hex = :crypto.hash(:md5,input)
    |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
    #hash = :crypto.hash(:md5, input)
    #:binary.bin_to_list(hash)
  end

  def pick_color(image) do
    %Identicon.Image{hex: [r,g,b|_tail]} = image
    %Identicon.Image{image|color: [r,g,b]}
  end

  def built_grid(%Identicon.Image{hex: hex} = image) do
    grid = 
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end
end
