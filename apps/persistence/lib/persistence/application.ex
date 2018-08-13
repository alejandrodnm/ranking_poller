defmodule Persistence.Application do
  @moduledoc """
  The Persistence Application Service.

  The persistence system business domain lives in this application.

  Exposes API to clients such as the `Persistence.Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Persistence.Repo, []),
    ], strategy: :one_for_one, name: Persistence.Supervisor)
  end
end
