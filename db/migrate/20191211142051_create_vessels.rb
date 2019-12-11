class CreateVessels < ActiveRecord::Migration[5.2]
  def change
    create_table :vessels do |t|
      t.string :name
      t.boolean :decommissioned, default: false

      t.timestamps
    end
  end
end
