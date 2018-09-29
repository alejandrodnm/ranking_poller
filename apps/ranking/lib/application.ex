defmodule Ranking.Application do
  @moduledoc """
  Ranking Application, starts the Ranking supervisor
  """
  use Application

  def start(_type, _args) do
    Ranking.Supervisor.start_link(name: Ranking.Supervisor)
  end
end
