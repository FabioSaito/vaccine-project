class Patient < ApplicationRecord
  after_create :create_vaccine_card

  has_one :vaccine_card, dependent: :destroy
  has_many :vaccines, through: :vaccine_card

  validates :name, presence: { message: 'is mandatory' }

  private

  def create_vaccine_card
    VaccineCard.create(patient: self)
  end
end
