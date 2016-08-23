class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.references :user
      t.string     :text
      t.timestamps null: false
    end
  end
end
