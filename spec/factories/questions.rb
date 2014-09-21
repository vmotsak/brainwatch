# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyText"
    user
  end

  trait :static_user do
    user User.first || user
  end

  factory :invalid_question, class: "Question" do
    title nil
    body "MyText"
  end
end
