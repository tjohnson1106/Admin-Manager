defmodule ServerQL.Schema do
  use Absinthe.Schema

  import_types(ServerQL.Schema.Types)

  query do
    field :employees, list_of(:employee) do
      resolve(&ServerQL.Cache.EmployeeResolver.all/2)
    end

    field :employee, :employee do
      arg(:id, :id)
      arg(:email, :string)

      resolve(&ServerQL.Cache.EmployeeResolver.get/2)
    end
  end
end
