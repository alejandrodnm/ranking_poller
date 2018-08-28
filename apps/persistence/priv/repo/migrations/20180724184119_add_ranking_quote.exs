defmodule Persistence.Repo.Migrations.AddRankingQuote do
  use Ecto.Migration

  def change do
    create table("ranking_quote") do
      add(:timestamp, :integer, null: false)
      add(:price, :decimal, null: false)
      add(:volume_24h, :decimal, null: false)
      add(:market_cap, :decimal, null: false)
      add(:percent_change_1h, :decimal, null: false)
      add(:percent_change_24h, :decimal, null: false)
      add(:percent_change_7d, :decimal, null: false)
      add(:last_updated, :integer, null: false)
      add(:circulating_supply, :decimal, null: false)
      add(:total_supply, :decimal, null: false)
      add(:max_supply, :decimal)
      add(:coin_id, references("ranking_coin"), null: false)
    end
  end
end
