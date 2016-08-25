class User < ActiveRecord::Base
  belongs_to :region
  belongs_to :tmp_region, class_name: "Region"

  def switch_questioner
    gimei = Gimei.name
    if self.questioner
      self.questioner = false
    else
      self.questioner = true
      self.name = gimei.last.hiragana
    end

    self.save!
  end

  def switch_region(opts = {})
    if opts[:region]
      self.tmp_region = opts[:region]
    else
      self.tmp_region = nil
    end

    self.save!
  end
end
