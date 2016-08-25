class Region < ActiveRecord::Base
  has_many :users
  has_many :tmp_users, class_name: "User", foreign_key: :tmp_region_id

end
