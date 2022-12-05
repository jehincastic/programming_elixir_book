list = [1, 2, 3, 4, 5]
[_head | tail] = list
[_head | tailOne] = tail
[_head | tailTwo] = tailOne
[head | tailThree] = tailTwo

IO.puts "head: #{head}"
IO.puts "tail => "
IO.inspect tailThree
IO.puts "List => "
IO.inspect list

defmodule MyNewList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)
end

IO.puts "List length: #{MyNewList.len(list)}"

defmodule SquareList do
  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]
end

IO.puts "Squared list: "
IO.inspect SquareList.square(list)

defmodule MyList do
  def max_fn(acc, val) when acc < val do
    val
  end

  def max_fn(acc, _val) do
    acc
  end

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def reduce([], val, _func), do: val
  def reduce([head | tail], val, func), do: reduce(tail, func.(val, head), func)

  def mapsum([], _fn), do: 0
  def mapsum([head | tail], fun), do: fun.(head) + mapsum(tail, fun)

  def max([]), do: nil
  def max([head | tail]), do: reduce(tail, head, fn(acc, val) -> max_fn(acc, val) end)

  def caesar([], _n), do: []
  def caesar([head | tail], n), do: [head + n | caesar(tail, n)]

  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from + 1, to)]
end

IO.inspect MyList.map [5, 7, 3], fn(x) -> x * x end
IO.inspect MyList.map [5, 7, 3], &(&1 * &1)
IO.inspect MyList.reduce([1, 2, 3, 4, 5], 0, &(&1 + &2))
IO.inspect MyList.mapsum([1, 2, 3], fn(x) -> x * x end)
IO.inspect MyList.max([1, 2, 3, 7, 8])
IO.inspect MyList.max([8, 5, 2, 4])
IO.inspect MyList.max([8, 15, 2, 4])
IO.inspect MyList.caesar('cdrlnmc', 1) # output: desmond


defmodule Swapper do
  def swap([]), do: []
  def swap([a, b | tail]), do: [b, a | swap(tail)]
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
end

IO.inspect Swapper.swap [1,2,3,4,5,6]

defmodule Data do
  def test_data do
    [
      [1366225622, 26, 15, 0.125],
      [1366225622, 27, 15, 0.45],
      [1366225622, 28, 21, 0.25],
      [1366229222, 26, 19, 0.081],
      [1366229222, 27, 17, 0.468],
      [1366229222, 28, 15, 0.60],
      [1366232822, 26, 22, 0.095],
      [1366232822, 27, 21, 0.05],
      [1366232822, 28, 24, 0.03],
      [1366236422, 26, 17, 0.025]
    ]
  end
end

defmodule WeatherHistory do
  def for_location([], _target_loc), do: []
  def for_location([ head = [_, target_loc, _, _ ] | tail], target_loc) do
    [ head | for_location(tail, target_loc)]
  end
  def for_location([_head | tail], target_loc), do: for_location(tail, target_loc)
end

IO.inspect WeatherHistory.for_location(Data.test_data, 28)
IO.inspect MyList.span(0, 10)
IO.inspect [1,2,3] ++ [4, 5, 6]
IO.inspect List.flatten([[[1], 2], [[[3]]]])
IO.inspect List.foldl([1, 2, 3], "", fn value, acc -> "#{value}(#{acc})" end)
IO.inspect List.foldr([1, 2, 3], "", fn value, acc -> "#{value}(#{acc})" end)
list = [1, 2, 3]
IO.inspect List.replace_at(list, 2, "Buckle My Shoe")
kw = [{:name, "Dave"}, {:likes, "Programming"}, {:where, "Dallas", "TX"}]
IO.inspect List.keyfind(kw, "Dallas", 1)
IO.inspect List.keyfind(kw, "TX", 2)
IO.inspect List.keyfind(kw, "TX", 1)
IO.inspect List.keyfind(kw, "TX", 1, "No city called TX")
kw = List.keydelete(kw, "TX", 2)
IO.inspect kw
kw = List.keyreplace(kw, :name, 0, {:first_name, "Dave"})
IO.inspect kw
