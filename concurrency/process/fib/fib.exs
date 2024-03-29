defmodule FibSolver do
  def fib(scheduler) do
    send(scheduler, { :ready, self() })
    receive do
      {:fib, n, client} ->
        send(client, { :answer, n, fib_calc(n), self() })
        fib(scheduler)
      {:shutdown} -> exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1) + fib_calc(n - 2)

  def main do
    to_process = List.duplicate(37, 5)
 	  Enum.each 1..10, fn num_processes ->
 	    {time, result} = :timer.tc(
        Scheduler, :run,
        [num_processes, FibSolver, :fib, to_process]
      )

      if num_processes == 1 do
        IO.puts inspect result
        IO.puts "\n #   time (s)"
      end
      :io.format "~2B     ~.2f~n", [num_processes, time/1000000.0]
    end
  end
end
