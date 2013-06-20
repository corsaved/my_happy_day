class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :date
      t.boolean :recurring
      t.string :period

      t.timestamps
    end
  end
end
