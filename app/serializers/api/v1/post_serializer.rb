module Api
  module V1  
    class Api::V1::PostSerializer < ActiveModel::Serializer
      attributes :id, :created_at, :updated_at, :body, :comments
      
      has_many :comments, if: :show_or_update_action?
      
      def comments
        if show_or_update_action?
          object.comments.order(created_at: :desc)
        else
          object.comments.count
        end
      end
      
      def show_or_update_action?
        instance_options[:action_name] == "show" || instance_options[:action_name] == "update"
      end
    end
  end
end
