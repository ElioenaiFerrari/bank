defmodule Bank.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :agency, :string
      add :number, :string
      add :user_id, references(:users, type: :uuid)


      timestamps()
    end

    create unique_index(:accounts, [:number, :user_id])
  end
end
