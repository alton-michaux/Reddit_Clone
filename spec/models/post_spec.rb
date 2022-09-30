# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { FactoryBot.create(:post) }
  let!(:account) { FactoryBot.create(:account) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is only valid with a title' do
    expect(subject.title).to_not be_nil
  end
  it 'is only valid with a body' do
    subject.body = nil
    expect(subject).to_not be_valid
  end
  it 'is only valid with an account_id' do
    expect(subject.account_id).to_not be_nil
  end
  it 'is only valid with a community_id' do
    expect(subject.community_id).to_not be_nil
  end
  it 'receives upvotes from accounts' do
    subject.liked_by account
    expect(subject.get_upvotes.size).to eq(1)
  end
  it 'receivers downvotes from accounts' do
    subject.disliked_by account
    expect(subject.get_downvotes.size).to eq(1)
  end
end
