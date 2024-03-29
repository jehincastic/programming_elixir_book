defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send(next_pid, n + 1)
    end
  end

  def create_process(n) do
    code_to_run = fn (_, send_to) ->
      spawn(Chain, :counter, [send_to])
    end

    last = Enum.reduce(1..n, self(), code_to_run)
    send(last, 0)

    receive do
      final_val when is_integer(final_val) ->
        "Result is #{inspect(final_val)}"
    end
  end

  def run(n) do
    :timer.tc(Chain, :create_process, [n])
    |> IO.inspect
  end
end

# To run this
# elixir --erl "+P 1000000" -r concurrency/process/process_overhead.exs -e "Chain.run(1_000_000)"
# +P 1000000 -> Is to add a limit on number of porcesses
