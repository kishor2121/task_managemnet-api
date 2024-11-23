class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.string :priority
      t.datetime :remind_before_at
      t.boolean :completion_status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
