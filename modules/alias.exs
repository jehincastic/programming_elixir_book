defmodule AnotherModule.Parser do
  def parse(src) do
    src
    |> String.upcase
  end
end

defmodule AnotherModule.Runner do
  def execute(src) do
    src
    |> String.split("")
    |> Enum.filter(&(&1 !== ""))
  end
end

defmodule Example do
  def compile_and_go(src) do
    alias AnotherModule.Parser, as: P
    alias AnotherModule.Runner
    # alias My.Other.Module.{Parser, Runner}
    src
    |> P.parse
    |> Runner.execute
  end
end

IO.inspect(Example.compile_and_go("hello"))
