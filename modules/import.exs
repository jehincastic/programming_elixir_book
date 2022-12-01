defmodule Example do
  def func1 do
    List.flatten [1, [2, 3], 4]
  end

  def func2 do
    import List, only: [flatten: 1]
    # import Module [, only:|except: ]
    flatten [1, [2, 3], 4]
  end
end

IO.inspect(Example.func1)
IO.inspect(Example.func2)
