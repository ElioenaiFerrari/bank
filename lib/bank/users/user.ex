defmodule Bank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bank.Accounts

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    has_one :account, Accounts.Account

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :password_confirmation])
    |> validate_required([:name, :email, :password, :password_confirmation])
    |> validate_length(:password, min: 6, message: "password be short")
    |> validate_confirmation(:password, message: "passwords most be equals")
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email, message: "email already in use")
    |> hash_password()
    |> cast_assoc(:account)
  end

  defp hash_password(
         %Ecto.Changeset{
           valid?: true,
           changes: %{password: password}
         } = changeset
       ) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp hash_password(changeset), do: changeset
end
