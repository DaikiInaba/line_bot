class KeywordsController < ApplicationController
  def new
    @keyword = Keyword.new
  end

  def create
    user = User.find_by(keyword_params[:mid])
    keyword = keyword.create(keyword_params)
  end

  private
  def keyword_params
    params.require(:keyword).permit(:text, :mid)
  end
end
