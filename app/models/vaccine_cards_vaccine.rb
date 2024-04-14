class VaccineCardsVaccine < ApplicationRecord
  belongs_to :vaccine_card
  belongs_to :vaccine
end
