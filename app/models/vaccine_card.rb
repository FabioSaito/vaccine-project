class VaccineCard < ApplicationRecord
  belongs_to :patient
  has_and_belongs_to_many :vaccines
end
