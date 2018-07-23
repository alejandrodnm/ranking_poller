defmodule Persistence.Repo.Migrations.AddRankingCoin do
  use Ecto.Migration

  def change do
    create table("ranking_coin", primary_key: false) do
      add(:id, :integer, primary_key: true)
      add(:name, :string)
      add(:website_slug, :string)
      add(:symbol, :string)
    end

    create(index("ranking_coin", [:name], unique: true))
    create(index("ranking_coin", [:website_slug], unique: true))
    create(index("ranking_coin", [:symbol], unique: true))
  end
end
