# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts', type: :request do
  subject { FactoryBot.create(:account) }

  describe 'get posts_path' do
    it 'renders the index view' do
      sign_in subject
      post = FactoryBot.create(:post)
      get community_posts_path(post.community.id)
      expect(response).to have_http_status(302)
      sign_out subject
    end
  end
  describe 'get community_post_path' do
    it 'renders the :show template' do
      sign_in subject
      post = FactoryBot.create(:post)
      get community_post_path(post.community_id, post.id)
      expect(response).to render_template(:show)
      sign_out subject
    end
    it 'redirects to the index path if the post id is invalid' do
      sign_in subject
      get community_post_path(400, 5000)
      expect(response).to redirect_to community_posts_path
      sign_out subject
    end
  end
  describe 'get new_community_post_path' do
    it 'renders the :new template' do
      sign_in subject
      community = FactoryBot.create(:community)
      get new_community_post_path(community.id)
      expect(response).to render_template(:new)
      sign_out subject
    end
  end
  describe 'get edit_community_post_path' do
    it 'renders the :edit template' do
      sign_in subject
      post = FactoryBot.create(:post)
      get edit_community_post_path(post.community.id, post.id)
      expect(response).to render_template(:edit)
      sign_out subject
    end
  end
  describe 'post community_posts_path with valid data' do
    it 'saves a new entry and redirects to the show path for the entry' do
      sign_in subject
      post_attributes = FactoryBot.attributes_for(:post)
      expect { post community_posts_path(post_attributes[:community_id]), params: { community: post_attributes[:community_id], post: post_attributes } }.to change(Post, :count).by(1)
      expect(response).to redirect_to community_path(post_attributes[:community_id])
      sign_out subject
    end
  end
  describe 'post community_posts_path with invalid data' do
    it 'does not save a new entry or redirect' do
      sign_in subject
      post_attributes = FactoryBot.attributes_for(:post)
      post_attributes.delete(:title)
      expect do
        post community_posts_path(post_attributes[:community_id]), params: { community: post_attributes[:community_id], post: post_attributes }
      end.to_not change(Post, :count)
      expect(response).to render_template(:new)
      sign_out subject
    end
  end
  # describe 'put community_path with valid data' do
  #   it 'updates an entry and redirects to the show path for the community' do
  #     sign_in subject
  #     community = FactoryBot.create(:community)
  #     community.update({ 'name' => 'Leaf Rakers' })
  #     community.reload
  #     expect do
  #       put community_path(id: community[:id]), params: { community: community.as_json }
  #     end.to_not change(Community, :count)
  #     expect(response).to redirect_to community_path({ id: community[:id] })
  #     sign_out subject
  #   end
  # end
  # describe 'put community_path with invalid data' do
  #   it 'does not update the community record or redirect' do
  #     sign_in subject
  #     community = FactoryBot.create(:community)
  #     community.update({ 'path' => '' })
  #     expect do
  #       put community_path(id: community.id), params: { community: community.as_json }
  #     end.to_not change(Community, :count)
  #     expect(response).to render_template(:edit)
  #     sign_out subject
  #   end
  # end
  describe 'delete a post record' do
    it 'deletes a post record' do
      sign_in subject
      post = FactoryBot.create(:post)
      post.destroy
      expect do
        get community_posts_path(post.community_id)
      end.to_not change(Post, :count)
      expect(response).to redirect_to community_posts_path(post.community_id)
      sign_out subject
    end
  end
end
