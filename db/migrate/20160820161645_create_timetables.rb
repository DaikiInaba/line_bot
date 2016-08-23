class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.string     :mon_first
      t.string     :mon_second
      t.string     :mon_third
      t.string     :mon_forth
      t.string     :mon_fifth
      t.string     :mon_sixth
      t.string     :tue_first
      t.string     :tue_second
      t.string     :tue_third
      t.string     :tue_forth
      t.string     :tue_fifth
      t.string     :tue_sixth
      t.string     :wed_first
      t.string     :wed_second
      t.string     :wed_third
      t.string     :wed_forth
      t.string     :wed_fifth
      t.string     :wed_sixth
      t.string     :thu_first
      t.string     :thu_second
      t.string     :thu_third
      t.string     :thu_forth
      t.string     :thu_fifth
      t.string     :thu_sixth
      t.string     :fri_first
      t.string     :fri_second
      t.string     :fri_third
      t.string     :fri_forth
      t.string     :fri_fifth
      t.string     :fri_sixth
      t.string     :sat_first
      t.string     :sat_second
      t.string     :sat_third
      t.string     :sat_forth
      t.string     :sat_fifth
      t.string     :sat_sixth
      t.string     :mid
      t.references :timeshifts

      t.timestamps null: false
    end
  end
end
