class SerenitizerController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @snippet = Snippet.new
  end

  def translate
    @snippet = Snippet.new
    @snippet.set_text(params[:snippet]["text"])
  end
end
