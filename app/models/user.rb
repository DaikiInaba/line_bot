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

  def switch_region(opts = {})
    if opts[:region]
      self.tmp_region_id = opts[:region].id
    else
      self.tmp_region_id = 0
    end

    self.save!
  end
end
