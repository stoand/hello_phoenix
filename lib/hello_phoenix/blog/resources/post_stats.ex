defmodule HelloPhoenix.Blog.PostStats do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJsonApi.Resource],
    authorizers: [Ash.Policy.Authorizer]

  # import Ash.Filter.TemplateHelpers

  json_api do
    type "post_stat"

    includes [:posts]

    routes do
      base "/post_stats"

      get :read
      index :read, default_fields: [:id]
      # index :read, default_fields: [:id, :post_count]
      post :create

      # relationship :posts, :read, default_fields: [:id, :title, :content]
    end
  end

  policies do
    policy always() do
      authorize_if always()
    end
  end

  postgres do
    table "post_stats"
    repo HelloPhoenix.Repo
  end

  code_interface do
    define_for HelloPhoenix.Blog
    define :create
    define :read, get?: true
  end
  
  actions do
    defaults [:read, :create]
  end

  attributes do
    uuid_primary_key :id
  end

  relationships do
    has_many :posts, HelloPhoenix.Blog.Post do
      # no_attributes? true
      destination_attribute :post_stats_id2 
    end
  end
  

  aggregates do
     count :post_count, :posts
    # do
    #   filter expr(content != nil)
    # end
  end
end
