defmodule Persistence.Repo.Migrations.AddStandingsCoin do
  use Ecto.Migration

  def change do
    create table("standings_coin", primary_key: false) do
      add(:id, :integer, primary_key: true)
      add(:name, :string)
      add(:slug, :string)
      add(:symbol, :string)
    end

    create(index("standings_coin", [:name], unique: true))
    create(index("standings_coin", [:slug], unique: true))
    create(index("standings_coin", [:symbol], unique: true))
  end
end
