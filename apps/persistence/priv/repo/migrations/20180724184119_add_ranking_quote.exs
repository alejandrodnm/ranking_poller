defmodule Persistence.Repo.Migrations.AddRankingQuote do
  use Ecto.Migration

  def change do
    create table("ranking_quote") do
      timestamps(type: :utc_datetime)
      add(:timestamp, :integer, null: false)
      add(:price, :decimal, null: false)
      add(:volume_24h, :integer, null: false)
      add(:market_cap, :integer, null: false)
      add(:percent_change_1h, :decimal, null: false)
      add(:percent_change_24h, :decimal, null: false)
      add(:percent_change_7d, :decimal, null: false)
      add(:last_updated, :integer, null: false)
      add(:coin_id, references("ranking_coin"), null: false)
    end
  end
end
