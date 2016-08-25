class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text       :text
      t.integer    :stage

      t.timestamps null: false
    end
  end
end
