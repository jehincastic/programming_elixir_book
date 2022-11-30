transformed_value = (1..10)
  |> Enum.map(&(&1 * &1))
  |> Enum.filter(&(&1 < 40))

IO.inspect transformed_value
