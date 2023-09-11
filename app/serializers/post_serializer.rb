class PostSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :body, :comments

  has_many :comments

  def comments
    if instance_options[:action_name] == "show"
      object.comments.order(created_at: :desc)
    else
      object.comments.size
    end
  end
end
