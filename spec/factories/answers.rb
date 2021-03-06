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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    body 'TheAnswerBody'
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end

end
