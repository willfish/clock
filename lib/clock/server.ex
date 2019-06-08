defmodule Clock.Server do
  use GenServer

  def start_link(_), do: GenServer.start_link(__MODULE__, %{})

  def init(_) do
    interval = Application.get_env(:clock, :interval)
    state = %{interval: interval}

    IO.puts("Initialized with interval #{interval} ms")

    {:ok, state, 0}
  end

  def handle_info(:timeout, state) do
    date = DateTime.utc_now() |> DateTime.to_iso8601()
    version = Application.spec(:clock, :vsn)

    IO.puts("Clock Server [\"#{version}\"] #{date}")

    {:noreply, state, state[:interval]}
  end
end
