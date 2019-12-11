class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.string :name
      t.float :distance
      t.string :origin
      t.string :destination
      t.references :vessel, foreign_key: true

      t.timestamps
    end
  end
end
