defmodule HelloPhoenix.Blog.Post do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJsonApi.Resource]

  json_api do
    type "post"

    routes do
      base "/posts"

      get :read
      index :read
      post :create
    end
  end

  postgres do
    table "posts"
    repo HelloPhoenix.Repo
  end

  code_interface do
    define_for HelloPhoenix.Blog
    define :create
    define :read_all, action: :read
    define :update, action: :update
    define :destroy, action: :destroy
    define :get_by_id, args: [:id], action: :by_id
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      # single result
      get? true
      filter expr(id == ^arg(:id))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
    end

    # can be nil
    attribute :content, :string
  end
end
