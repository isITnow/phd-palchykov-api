class Api::V1::ResearchSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :payload, :illustrations
  
  has_many :illustrations
  
  def illustrations
    object.illustrations
  end
end

