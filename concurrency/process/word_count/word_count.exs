defmodule WordCounter do
  def count(scheduler) do
    send(scheduler, {:ready, self()})
    receive do
      {:count, file, word, client} ->
        send(client, {:answer, file, word, count_word(file, word), self()})
        count(scheduler)
      {:shutdown} ->
        exit(:normal)
    end
  end

  defp count_word(file, word) do
    content = File.read!(file)
    split_str = String.split(content, word)
    length(split_str) - 1
  end
end
