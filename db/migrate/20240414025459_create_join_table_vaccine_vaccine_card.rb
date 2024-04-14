class CreateJoinTableVaccineVaccineCard < ActiveRecord::Migration[7.1]
  def change
    create_join_table :vaccines, :vaccine_cards
  end
end
