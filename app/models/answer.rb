# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  accepted    :boolean
#
# Indexes
#
#  index_answers_on_user_id  (user_id)
#

class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :attachments

  validates :body, presence: true
end
