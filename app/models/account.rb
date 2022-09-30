# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name, :bio, :email, :username
  validates :email, format: { with: /\A\S+@\S+[.]\S+\z/,
                              message: 'Invalid Email' }

  has_many :posts
  has_many :subscriptions
  has_many :communities, through: :subscriptions

  acts_as_voter

  def full_name
    "#{first_name} #{last_name}"
  end
end
