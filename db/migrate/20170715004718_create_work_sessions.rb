class CreateWorkSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :work_sessions do |t|
      t.date :date, null: false
      t.string :description, null: false
      t.boolean :is_billable, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
    end
  end
end
