defmodule Ranking do
  @moduledoc """
  Maintains the ranking of the virtual coins.
  """
  alias Ranking.Import

  @doc """
  Executes the import job that fetches the current ranking and stores
  it in the database.
  """
  def fetch_current do
    Import.run()
  end
end
