class Vaccine < ApplicationRecord
  has_and_belongs_to_many :vaccine_cards

  validates :name, presence: { message: 'is mandatory' }
  validates :slug, uniqueness: { scope: :dose }

  enum dose: {
    first: 0,
    second: 1,
    third: 2,
    first_booster: 3,
    second_booster: 4
  }, _suffix: true
end
