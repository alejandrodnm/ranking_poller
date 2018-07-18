defmodule Ranking do
  @moduledoc """
  Documentation for Standings.
  """

  @doc """
  Hello world.
  """
  def fetch_current do
    Provider.get_ranking()
  end
end
