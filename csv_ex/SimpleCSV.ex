defmodule SimpleCSV do
  def read(filename) do
    file = File.open!(filename)
    headers = read_headers(IO.read(file, :line))
    Enum.map(IO.stream(file, :line), &create_one_row(headers, &1))
  end

  defp read_headers(hdr_line) do
    from_csv_and_map(hdr_line, &String.to_atom(&1))
  end

  defp create_one_row(headers, row_csv) do
    row = from_csv_and_map(row_csv, &maybe_convert_numbers(&1))
    Enum.zip(headers, row)
  end

  defp from_csv_and_map(row_csv, mapper) do
    row_csv
    |> String.trim
    |> String.split(~r{,\s*})
    |> Enum.map(mapper)
  end

  defp maybe_convert_numbers(value) do
    cond do
      Regex.match?(~r{^\d+\.\d+$}, value) -> String.to_float(value)
      Regex.match?(~r{^\d+$}, value) -> String.to_integer(value)
      << ?: :: utf8, name :: binary >> = value -> String.to_atom(name)
      true -> value
    end
  end
end

orders = SimpleCSV.read("sales_data.csv")
IO.inspect orders
