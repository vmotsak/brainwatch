feature 'Question' do

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "Ask Question"
  scenario 'visit the home page' do
    visit root_path
    expect(page).to have_link 'Ask Question'
  end

  scenario 'ask question' do
    visit new_question_path
    fill_in 'Title', with: 'Question title'
    fill_in 'Body', with: 'My question'
    click_on 'Ask'
  end

end