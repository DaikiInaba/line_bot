class User < ActiveRecord::Base
  has_many :keywords
  validates :mid
end
