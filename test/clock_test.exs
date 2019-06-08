defmodule ClockTest do
  use ExUnit.Case

  test "starts a Clock" do
    assert {:ok, _} = Clock.start("foo", "bar")
  end
end
