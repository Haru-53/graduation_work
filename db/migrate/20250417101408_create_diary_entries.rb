class CreateDiaryEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :diary_entries do |t|
      t.date :date
      t.text :positive_point1
      t.text :positive_point2
      t.text :positive_point3
      t.text :reflection_point
      t.text :memo

      t.timestamps
    end
  end
end
