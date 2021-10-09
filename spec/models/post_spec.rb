# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { FactoryBot.create(:post) }
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
  it 'is only valid with upvotes' do
    subject.upvotes = nil
    expect(subject).to_not be_valid
  end
  it 'is only valid with downvotes' do
    subject.downvotes = nil
    expect(subject).to_not be_valid
  end
  it 'is only valid with an account_id' do
    expect(subject.account_id).to_not be_nil
  end
  it 'is only valid with a community_id' do
    expect(subject.community_id).to_not be_nil
  end
end

