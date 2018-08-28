defmodule Persistence.Repo.Migrations.AddRankingImport do
  use Ecto.Migration

  def change do
    create table("ranking_import") do
      timestamps(type: :utc_datetime, updated_at: false)
      add(:timestamp, :integer, null: false)
      add(:num_cryptocurrencies, :integer, null: false)
      add(:error, :string, null: false)
    end

    alter table("ranking_quote") do
      add(:ranking_import_id, references("ranking_import"), null: false)
    end

    create(index("ranking_quote", [:ranking_import_id, :coin_id], unique: true))

    create(
      index("ranking_import", ["(date(inserted_at))"],
        unique: true,
        name: "idx_created_at_date"
      )
    )
  end
end
