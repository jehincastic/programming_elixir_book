defmodule MyEnum do
    def all?(list, cond?) when is_list(list) and is_function(cond?) do
        do_all?(list, cond?)
    end

    defp do_all?([h | t], cond?) do
        if cond?.(h) do
            do_all?(t, cond?) 
        else
            false
        end
    end

    defp do_all?([], _), do: true


    def each(list, fun) when is_list(list) and is_function(fun) do
        do_each(list, fun)
    end

    defp do_each([h | t], fun) do
        fun.(h)
        do_each(t, fun)
    end

    defp do_each([], _), do: :done

    def filter(list, fun?) when is_list(list) and is_function(fun?) do
        do_filter(list, fun?, [])
    end

    defp do_filter([h | t], fun?, return_val) do
        if fun?.(h) do
            do_filter(t, fun?, return_val ++ [h])
        else
            do_filter(t, fun?, return_val)
        end
    end

    defp do_filter([], _, return_val), do: return_val

    def split(list, split_at) when is_list(list) and is_integer(split_at) do
        do_split(list, split_at, 0, [])
    end

    defp do_split([h | t], split_at, idx, return_val) do
        if idx === split_at do
            {return_val, [h | t]}
        else
            new_idx = idx + 1
            do_split(t, split_at, new_idx, return_val ++ [h])
        end
    end

    defp do_split([], _, _, return_val), do: {return_val, []}

    def take(list, n) when is_list(list) and is_integer(n) do
        if n < 0 do
            do_take(Enum.reverse(list), n, [])
        else
            do_take(list, n, []) 
        end
    end

    defp do_take(list, n, return_val) when list === [] or n === 0, do: return_val

    defp do_take([h | t], n, return_val) when n > 0 do
        do_take(t, n - 1, return_val ++ [h])
    end

    defp do_take([h | t], n, return_val) when n < 0 do
        do_take(t, n + 1, [h] ++ return_val)
    end

    def flatten(list) do
        do_flatten(list, [])
    end

    defp do_flatten([h | l], return_val) when is_list(h) do
        new_return_val = do_flatten(h, return_val)
        do_flatten(l, new_return_val)
    end

    defp do_flatten([h | l], return_val) do
        do_flatten(l, return_val ++ [h])
    end

    defp do_flatten([], return_val), do: return_val
end

IO.inspect MyEnum.all?([1, 2, 3], &(&1 > 0))
IO.inspect MyEnum.all?([], &(&1 > 0))
IO.inspect MyEnum.each(["apple", "is", "a", "fruit"], &IO.puts/1)
IO.inspect MyEnum.each([], &IO.puts/1)
IO.inspect MyEnum.filter([1353, 2334, 45, 12353, 23344], &(&1 > 1500))
IO.inspect MyEnum.split([1000, 2000, 3000, 4000, 5000], 3)
IO.inspect MyEnum.split([10, 20, 30, 40, 50], 30)
IO.inspect MyEnum.take([10, 20, 30, 40, 50], 3)
IO.inspect MyEnum.take([10, 20, 30, 40, 50], 30)
IO.inspect MyEnum.take([1000, 2000, 3000, 4000, 5000], -3)
IO.inspect MyEnum.take([10, 20, 30, 40, 50], 0)
IO.inspect MyEnum.take([], 10)
IO.inspect MyEnum.flatten([ 1, [ 2, 3, [4] ], 5, [[[6]]]])
