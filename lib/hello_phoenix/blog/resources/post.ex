defmodule HelloPhoenix.Blog.Post do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJsonApi.Resource],
    authorizers: [Ash.Policy.Authorizer]

  import Ash.Filter.TemplateHelpers

  json_api do
    type "post"
    includes [:post_stats]

    routes do
      base("/posts")

      get(:read)
      get :by_title, route: "/by_title/:title"
      index :read, default_fields: [:id, :title, :content, :title_twice]
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

    policy action(:by_title) do
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

    read :by_title do
      argument :title, :string, allow_nil?: false
      filter(title: arg(:title))
    end

    action :get_first_title, :string do
      run fn input, context ->
        {:ok, "asdf"}
      end
    end
  end

  relationships do
    belongs_to :post_stats, HelloPhoenix.Blog.PostStats do
      source_attribute :post_stats_id2
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
    end

    # can be nil
    attribute :content, :string

    # attribute :post_stats_id, :uuid

    attribute :post_stats_id2, :uuid
  end

  calculations do
    calculate(:title_twice, :string, concat([:title, :title], "-"))
  end
end
