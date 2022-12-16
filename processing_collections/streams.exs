# not optimal code
[1,2,3,4,5]
    |> Enum.map(&(&1 * &1))
    |> Enum.with_index
    |> Enum.map(fn {value, index} -> value - index end)
    |> IO.inspect

IO.puts File.read!("/usr/share/dict/words")
    |> String.split
    |> Enum.max_by(&String.length/1)

# Stream Implementation
s = Stream.map [1, 2, 3, 4, 5], &(&1*&1)
IO.inspect Enum.to_list s

val = [1,2,3,4,5]
    |> Stream.map(&(&1 * &1))
    |> Stream.map(&(&1+1))
    |> Stream.filter(fn x -> rem(x, 2) == 1 end)
    |> Enum.to_list
IO.inspect val

IO.puts File.open!("/usr/share/dict/words")
    |> IO.stream(:line)
    |> Enum.max_by(&String.length/1)

IO.puts File.stream!("/usr/share/dict/words")
    |> Enum.max_by(&String.length/1)

IO.inspect Enum.map(1..10_000_000, &(&1+1)) |> Enum.take(5)
IO.inspect Stream.map(1..10_000_000, &(&1+1)) |> Enum.take(5)

Stream.cycle(~w{ green white })
    |> Stream.zip(1..5)
    |> Enum.map(fn {class, value} -> "<div class=#{class}>#{value}</div>" end)
    |> IO.puts

IO.inspect Stream.repeatedly(&:random.uniform/0) |> Enum.take(5)

IO.inspect Stream.iterate(2, &(&1 * &1)) |> Enum.take(5)
IO.inspect Stream.iterate(10, &({&1, "hello"})) |> Enum.take(5)

IO.inspect Stream.unfold({0, 1}, fn {f1, f2} -> {f1, {f2, f1+f2}} end) |> Enum.take(5)
