defmodule Countdown do
    def sleep(seconds) do
        receive do
            after seconds * 1000 -> nil
        end
    end

    def say(txt) do
        spawn fn -> :os.cmd('espeak #{txt}') end
    end

    def timer do
        Stream.resource(fn ->
            {_h, _m, s} = :erlang.time
            60 - s - 1
        end,
        fn
            0 -> {:halt, 0}
            count ->
                sleep(1)
                { [inspect(count)], count - 1 }
        end,
        fn _ -> nil end
        )
    end
end

counter = Countdown.timer
printer = counter |> Stream.each(&IO.puts/1)
speaker = printer |> Stream.each(&Countdown.say/1)
IO.puts "Start"
IO.inspect speaker |> Enum.take(5)
IO.inspect speaker |> Enum.to_list
