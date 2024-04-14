class Vaccine < ApplicationRecord
  validates :name, presence: { message: 'is mandatory' }
end
