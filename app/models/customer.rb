class Customer < ApplicationRecord
  validates :email, :firstName, :lastName, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                              message: "Must be valid email address"}

  def create(args)
    Customer.create(args)
  end


end