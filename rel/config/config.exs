use Mix.Config

get_env = fn var, default ->
  System.get_env(var) || default
end

config :clock,
  interval: get_env.("INTERVAL", "1000") |> String.to_integer()
