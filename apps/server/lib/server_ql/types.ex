defmodule ServerQL.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Server.Repo

  object :employee do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
  end
end
