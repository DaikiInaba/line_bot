class User < ActiveRecord::Base
  belongs_to :region

  def switch_questioner
    gimei = Gimei.name
    if self.questioner
      self.questioner = false
    else
      self.questioner = true
      self.name = gimei.last.katakana
    end

    self.save!
  end
end
