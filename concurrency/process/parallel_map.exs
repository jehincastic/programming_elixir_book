defmodule Parallel do
  def pmap(coll, fun) do
    me = self()
    coll
      |> Enum.map(
          fn elem ->
            spawn_link(
              fn() ->
                send(me, { self(), fun.(elem) })
              end
            )
          end
        )
      |> Enum.map(fn pid ->
        receive do {^pid, res} -> res end
      end)
  end
end

IO.inspect Parallel.pmap(1..10, &(&1 * &1))
# :timer.tc(Parallel, :pmap, [1..10, fn (val) ->
#   :timer.sleep(5000)
#   val * val
# end])
#   |> IO.inspect
