defmodule BankWeb.Auth.Guardian do
  use Guardian, otp_app: :bank

  alias Bank.{Users, Users.User}

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, to_string(id)}
  end

  def subject_for_token(_, _), do: {:error, :reason_for_error}

  def resource_from_claims(%{"sub" => sub}) do
    user = Users.get_user!(sub)
    {:ok, user}
  end

  def resource_from_claims(_claims), do: {:error, :reason_for_error}

  def authenticate(%{"email" => email, "password" => password}) do
    case Users.get_by_email!(email) do
      nil -> {:error, :not_found, "user not found"}
      user -> validate_password(user, password)
    end
  end

  defp validate_password(%User{password_hash: password_hash} = user, password) do
    case Bcrypt.verify_pass(password, password_hash) do
      true -> create_token(user)
      false -> {:error, :unauthorized, "unauthorized"}
    end
  end

  defp create_token(user = %User{}) do
    {:ok, token, _claims} = encode_and_sign(user)

    {:ok, token}
  end
end
