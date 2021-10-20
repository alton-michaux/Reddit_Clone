# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Community, type: :model do
  subject { FactoryBot.create(:community) }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is only valid with a url' do
    expect(subject.url).to_not be_nil
  end
  it 'is only valid with a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'is only valid with rules' do
    subject.rules = nil
    expect(subject).to_not be_valid
  end
  it 'is only valid with an account' do
    expect(subject.account).to_not be_nil
  end
end
