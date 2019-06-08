defmodule Clock do
  @moduledoc """
  A simple clock application with writes the current time on an interval to stdout.
  """

  use Application

  @doc """
  Start the clock application
  """
  def start(_type, _args) do
    children = [{Clock.Server, []}]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
