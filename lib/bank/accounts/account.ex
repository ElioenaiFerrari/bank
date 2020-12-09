defmodule Bank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bank.Users

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :agency, :string
    field :number, :string
    belongs_to :user, Users.User

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:agency, :number, :user_id])
    |> validate_required([:agency, :number, :user_id])
    |> cast_assoc(:user)
  end
end
