defmodule HelloPhoenix.Blog.Post do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJsonApi.Resource],
    authorizers: [Ash.Policy.Authorizer]

  import Ash.Filter.TemplateHelpers

  json_api do
    type "post"

    routes do
      base("/posts")

      get(:read)
      index :read
      post(:create)

      index :get_first_title, route: "/title"
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

    define :get_first_title
  end

  policies do
    policy action(:read) do
      authorize_if expr(title != "asdf")
    end

    policy action(:create) do
      authorize_if always()
    end
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      # single result
      get? true
      filter expr(id == ^arg(:id))
    end

    action :get_first_title, :string do
      run fn input, context ->
        {:ok, "asdf"}
      end
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
    end

    # can be nil
    attribute :content, :string

    attribute :post_stats_id, :uuid
  end
end
