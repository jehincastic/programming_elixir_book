import Enum
require Integer

list = Enum.to_list 1..5

IO.inspect list

IO.inspect Enum.concat([10, 11, 12], list)
IO.inspect Enum.concat([0, 1, 2], 'abc')

IO.inspect Enum.map(list, &(&1 * 10))
IO.inspect Enum.map(list, &String.duplicate("*", &1))

IO.inspect Enum.at(1..10, 3)
IO.inspect Enum.at(1..10, 30, :nothing)

IO.inspect Enum.filter(list, &Integer.is_even/1)
IO.inspect Enum.reject(list, &Integer.is_even/1)

IO.inspect Enum.sort ["there", "was", "a", "crooked", "man"]
IO.inspect Enum.sort ["there", "was", "a", "crooked", "man"], &(String.length(&1) <= String.length(&2))
IO.inspect Enum.max ["there", "was", "a", "crooked", "man"]
IO.inspect Enum.max_by ["there", "was", "a", "crooked", "man"], &String.length/1

IO.inspect Enum.take(list, 3)
IO.inspect Enum.take(list, 30)
IO.inspect Enum.take_every(list, 2)
IO.inspect Enum.take_while(list, &(&1 < 4))
IO.inspect Enum.split(list, 3)
IO.inspect Enum.split_while(list, &(&1 < 4))
IO.puts Enum.join(list)
IO.puts Enum.join(list, " <==> ")

IO.inspect Enum.all?(list, &(&1 < 4))
IO.inspect Enum.any?(list, &(&1 < 4))
IO.inspect Enum.member?(list, 4)
IO.inspect Enum.empty?(list)

IO.inspect Enum.zip(list, [:a, :b, :c])
IO.inspect Enum.zip(list, [:a, :b, :c, :d, :e, :f, :g])
IO.inspect Enum.with_index(list)

IO.inspect Enum.reduce(["now", "is", "the", "right", "time"], fn word, acc ->
    if String.length(word) > String.length(acc) do
        word
    else
        acc
    end
end)

IO.inspect Enum.reduce(["now", "is", "the", "right", "time"], 0, fn word, acc ->
    if String.length(word) > acc,
    do: String.length(word),
    else: acc
end)

deck = for rank <- '23456789JQKA', suit <- 'CDHS', do: [suit, rank]

IO.inspect deck

hands = deck |> shuffle |> chunk(13)

IO.inspect hands

IO.inspect Enum.into 1..5, []
IO.inspect Enum.into 1..5, [100, 101]
