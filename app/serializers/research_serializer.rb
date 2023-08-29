class ResearchSerializer < ActiveModel::Serializer
  attributes :id, :payload, :illustrations

  def illustrations
    object.illustrations
  end
end
