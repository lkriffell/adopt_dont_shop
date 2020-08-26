class AddFavoriteColumnToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :favorite, :boolean
  end
end
