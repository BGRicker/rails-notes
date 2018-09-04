require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe "notes#index action" do
    it "should successfully respond" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should return all Notes in ascending order" do
      2.times do
        FactoryBot.create(:note)
      end
      get :index
      json = JSON.parse(response.body)
      expect(json[0]['id'] < json[1]['id']).to be true
    end
  end

  describe "notes#create action" do
    before do
      post :create, params: { note: { title: 'Shopping List', content: 'Pizza' } }
    end

    it "should return 200 status-code" do
      expect(response).to be_success
    end

    it "should successfully create and save a new note in the database" do
      note = Note.last
      expect(note.title).to eq('Shopping List')
      expect(note.content).to eq('Pizza')
    end

    it "should return the created note in response body" do
      json = JSON.parse(response.body)
      expect(json['title']).to eq('Shopping List')
      expect(json['content']).to eq('Pizza')
    end
  end

  describe "notes#create action validations" do
    before do
      post :create, params: { note: { title: '', content: '' } }
    end

    it "should deal with validation errors" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should return error json on validation error" do
      json = JSON.parse(response.body)
      expect(json["errors"]["content"][0]).to eq("can't be blank")
      expect(json["errors"]["title"][0]).to eq("can't be blank")
    end
  end

  describe "notes#show action" do
    it "should return a note" do
      note = FactoryBot.create(:note)
      get :show, params: { id: note.id }
      json = JSON.parse(response.body)
      expect(json['id']).to eq(note.id)
    end
  end

  describe "notes#update action" do
    before do
      @note = FactoryBot.create(:note)
    end

    it "should receive the updated note in response" do
      put :update, params: { id: @note.id, note: { title: 'Updated First', content: 'Updated this note.' } }
      json = JSON.parse(response.body)
      expect(json['content']).to eq('Updated this note.')
      expect(json['title']).to eq('Updated First')
      expect(response).to be_success
    end

    it "should receive the updated note in response" do
      put :update, params: { id: @note.id, note: { title: '', content: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should return error json on validation error" do
      put :update, params: { id: @note.id, note: { title: '', content: '' } }
      json = JSON.parse(response.body)
      expect(json["errors"]["content"][0]).to eq("can't be blank")
      expect(json["errors"]["title"][0]).to eq("can't be blank")
    end
  end

  describe "notes#destroy action" do
    before do
      @note = FactoryBot.create(:note)
      delete :destroy, params: { id: @note.id }
    end

    it "should destroy a saved note" do
      note = Note.find_by_id(@note.id)
      expect(note).to eq nil
    end

    it "should return no_content status" do
      expect(response).to have_http_status(:no_content)
    end
  end
end
