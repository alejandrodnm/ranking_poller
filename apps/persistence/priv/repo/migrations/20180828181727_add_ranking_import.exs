defmodule Persistence.Repo.Migrations.AddImport do
  use Ecto.Migration

  def change do
    create table("ranking_import") do
      timestamps(type: :utc_datetime, updated_at: false)
      add(:timestamp, :integer, null: false)
      add(:num_cryptocurrencies, :integer, null: false)
      add(:error, :string)
    end

    alter table("ranking_quote") do
      add(:import_id, references("ranking_import"), null: false)
    end

    create(index("ranking_quote", [:import_id, :coin_id], unique: true))
  end
end
