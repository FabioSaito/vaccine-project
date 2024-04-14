class Patient < ApplicationRecord
  has_one :vaccine_card, dependent: :destroy
  has_many :vaccines, through: :vaccine_card

  validates :name, presence: { message: 'is mandatory' }
end
