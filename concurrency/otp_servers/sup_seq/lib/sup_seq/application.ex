defmodule SupSeq.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: SupSeq.Stash.start_link(arg)
      { SupSeq.Stash, 123 },
      # Starts a worker by calling: SupSeq.Server.start_link(arg)
      { SupSeq.Server, nil },
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: SupSeq.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
