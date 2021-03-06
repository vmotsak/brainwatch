require 'rails_helper'

describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    before { sign_in user }
    context 'with valid attributes' do
      it 'should create a Answer ' do
        expect do
          post :create, question_id: question, answer: attributes_for(:answer), format: :js
        end.to change(Answer, :count).by(1)
      end

      it 'should redirect to show' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template 'create'
      end

      it 'should set current user as answer creator' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(Answer.last.user).to eq user
      end
    end

    context 'with invalid attributes' do
      it 'should not save invalid answer' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        expect(assigns(:answer)).to be_a_new Answer
      end

      it 're-renders the create template' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        expect(response).to render_template('create')
      end
    end
  end
end
