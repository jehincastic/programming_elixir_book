defmodule SupSeqTest do
  use ExUnit.Case
  doctest SupSeq

  test "greets the world" do
    assert SupSeq.hello() == :world
  end
end
