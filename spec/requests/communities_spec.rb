# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Communities', type: :request do
  subject { FactoryBot.create(:account) }

  describe 'get communities_path' do
    it 'renders the index view' do
      sign_in subject
      FactoryBot.create_list(:community, 10)
      get communities_path
      expect(response).to render_template(:index)
      sign_out subject
    end
  end
  describe 'get community_path' do
    it 'renders the :show template' do
      sign_in subject
      community = FactoryBot.create(:community)
      get community_path(id: community.id)
      expect(response).to render_template(:show)
      sign_out subject
    end
    it 'redirects to the index path if the community id is invalid' do
      sign_in subject
      get community_path(id: 5000)
      expect(response).to redirect_to communities_path
      sign_out subject
    end
  end
  describe 'get new_community_path' do
    it 'renders the :new template' do
      sign_in subject
      get new_community_path
      expect(response).to render_template(:new)
      sign_out subject
    end
  end
  describe 'get edit_community_path' do
    it 'renders the :edit template' do
      sign_in subject
      community = FactoryBot.create(:community)
      get edit_community_path(id: community.id)
      expect(response).to render_template(:edit)
      sign_out subject
    end
  end
  describe 'post communities_path with valid data' do
    it 'saves a new entry and redirects to the show path for the entry' do
      sign_in subject
      community_attributes = FactoryBot.attributes_for(:community)
      expect { post communities_path, params: { community: community_attributes } }.to change(Community, :count).by(1)
      expect(response).to redirect_to community_path(id: Community.last.id)
      sign_out subject
    end
  end
  describe 'post communities_path with invalid data' do
    it 'does not save a new entry or redirect' do
      sign_in subject
      community_attributes = FactoryBot.attributes_for(:community)
      community_attributes[:name] = nil
      expect do
        post communities_path, params: { community: community_attributes }
      end.to_not change(Community, :count)
      expect(response).to redirect_to communities_path
      sign_out subject
    end
  end
  describe 'put community_path with valid data' do
    it 'updates an entry and redirects to the show path for the community' do
      sign_in subject
      community = FactoryBot.create(:community)
      community.update({ 'name' => 'Leaf Rakers' })
      community.reload
      expect do
        put community_path(id: community[:id]), params: { community: community.as_json }
      end.to_not change(Community, :count)
      expect(response).to redirect_to community_path({ id: community[:id] })
      sign_out subject
    end
  end
  describe 'put community_path with invalid data' do
    it 'does not update the community record or redirect' do
      sign_in subject
      community = FactoryBot.create(:community)
      community.update({ 'url' => '' })
      expect do
        put community_path(id: community.id), params: { community: community.as_json }
      end.to_not change(Community, :count)
      expect(response).to render_template(:edit)
      sign_out subject
    end
  end
  describe 'delete a community record' do
    it 'deletes a community record' do
      sign_in subject
      community = FactoryBot.create(:community)
      community.destroy
      expect do
        get communities_path
      end.to_not change(Community, :count)
      expect(response).to render_template(:index)
      sign_out subject
    end
  end
end
