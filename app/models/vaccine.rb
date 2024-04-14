class Vaccine < ApplicationRecord
  validates :name, presence: { message: 'is mandatory' }
  has_and_belongs_to_many :vaccine_cards
end
