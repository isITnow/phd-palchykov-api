module Api
  module V1
    module ErrorHandling
      extend ActiveSupport::Concern
      
      included do
        rescue_from ActiveRecord::RecordNotFound, with: :notfound
      end
      
      private
      
      def notfound
        render json: { error: 'Record not found' }, status: :not_found
      end
    end
  end
end