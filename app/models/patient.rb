class Patient < ApplicationRecord
  validates :name, presence: { message: 'is mandatory' }
end
