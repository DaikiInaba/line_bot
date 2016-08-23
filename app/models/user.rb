class User < ActiveRecord::Base
  has_many :keywords
  validate :mid
end
