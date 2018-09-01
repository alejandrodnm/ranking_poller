defmodule Persistence.Repo.Migrations.AddResults do
  use Ecto.Migration

  def change do
    create table("ranking_results") do
      timestamps(type: :utc_datetime, updated_at: false)
      add(:timestamp, :integer, null: false)
      add(:num_cryptocurrencies, :integer, null: false)
      add(:error, :string)
    end

    alter table("ranking_quote") do
      add(:results_id, references("ranking_results"), null: false)
    end

    create(index("ranking_quote", [:results_id, :coin_id], unique: true))

    create(
      index("ranking_results", ["(date(inserted_at))"],
        unique: true,
        name: "idx_created_at_date"
      )
    )
  end
end
