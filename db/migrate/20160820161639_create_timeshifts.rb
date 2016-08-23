class CreateTimeshifts < ActiveRecord::Migration
  def change
    create_table :timeshifts do |t|
      t.string     :school_name
      t.string     :school_name_kana
      t.time   :start_first
      t.time   :finish_first
      t.time   :start_second
      t.time   :finish_second
      t.time   :start_third
      t.time   :finish_third
      t.time   :start_forth
      t.time   :finish_forth
      t.time   :start_fifth
      t.time   :finish_fifth
      t.time   :start_sixth
      t.time   :finish_sixth

      t.timestamps null: false
    end
  end
end
