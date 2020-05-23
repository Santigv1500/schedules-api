class CreateScheduleDates < ActiveRecord::Migration[6.0]
  def change
    create_table :schedule_dates do |t|
      t.datetime :date
      t.integer :capacity
      t.timestamps
    end
  end
end
