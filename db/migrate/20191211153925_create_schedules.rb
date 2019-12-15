class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :route, foreign_key: true
      t.references :vessel, foreign_key: true
      t.string :days
      t.time :start_time
      t.time :end_time
      t.text :remarks
      t.string :type
      t.date :date

      t.timestamps
    end
  end
end
