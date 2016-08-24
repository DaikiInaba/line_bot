class User < ActiveRecord::Base
  belongs_to :region

  def switch_questioner
    gimei = Gimei.name
    if questioner
      questioner = false
    else
      questioner = true
      name = gimei.last.katakana
    end

    save
  end
end
