class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body,:user_id, :created_at, :updated_at

end
