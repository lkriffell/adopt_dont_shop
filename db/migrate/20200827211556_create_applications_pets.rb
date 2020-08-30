class CreateApplicationsPets < ActiveRecord::Migration[5.2]
  def change
    create_table :applications_pets do |t|
      t.references :applications, foreign_key: true
      t.references :pets, foreign_key: true
    end
  end
end
