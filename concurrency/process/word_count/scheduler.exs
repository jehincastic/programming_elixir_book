defmodule Scheduler do
  def run(num_processes, module, func, dir, word) do
    {:ok, files} = File.ls(dir)
    files = Enum.map(files, fn file -> Path.join(dir, file) end)
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    |> schedule_processes(files, word, Map.new)
  end

  def schedule_processes(processes, queue, words, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [next | tail] = queue
        send(pid, {:count, next, word, self()})
        schedule_processes(processes, tail, word, results)
      {:ready, pid} ->
        send(pid, {:shutdown})
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, word, results)
        else
          results
        end
      {:answer, file, _word, result, _pid} ->
        schedule_processes(processes, queue, word, Map.put(results, file, result))
    end
  end
end
