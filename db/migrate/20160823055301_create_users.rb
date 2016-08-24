class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text       :mid
      t.integer    :stage
      t.references :region
      t.timestamps null: false
    end
  end
end
