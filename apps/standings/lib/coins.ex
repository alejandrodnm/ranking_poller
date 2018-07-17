defmodule Standings.Coin do
  @moduledoc """
  Represents a blockchain coin.
  """
  use Ecto.Schema
  @primary_key false

  schema "coin table: standings_coin" do
    field(:id, :id, primary_key: true)
    field(:name, :string)
    field(:slug, :string)
    field(:symbol, :string)
  end
end
