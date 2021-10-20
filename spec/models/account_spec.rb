# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { FactoryBot.create(:account) }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is only valid with a first name' do
    expect(subject.first_name).to_not be_nil
  end
  it 'is only valid with a last name' do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end
  it 'is only valid with a username' do
    subject.username = nil
    expect(subject).to_not be_valid
  end
  it 'is only valid with a bio' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end
  it 'is only valid with a valid email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end
end
