class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text       :mid, null: false
      t.integer    :stage
      t.boolean    :question, null: false, default: false
      t.references :region
      t.timestamps null: false
    end
  end
end
