class Snippet
  require 'active_model'
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  @text

  def text
    @text
  end

  def set_text(text)
    @text = text
  end

  def translated
    to_be_translated = self.text.downcase

    # goram
    to_be_translated = to_be_translated.gsub(/[gG][oO][dD]\s[dD][aA][mM][mMnN]/, "goram")

    # replace thing with bunger
    to_be_translated = to_be_translated.gsub(/thing/, "bunger")

    # drop the 'g' on gerunds
    to_be_translated = to_be_translated.gsub(/[iI][nN][gG]/, "in'")

    # use the word ain't
    to_be_translated = to_be_translated.gsub(/[aA][rR][eE][nN]['][tT]/, "ain't")
    to_be_translated = to_be_translated.gsub(/[aA][rR][eE]\s[nN][oO][tT]/, "ain't")
    to_be_translated = to_be_translated.gsub(/are\syou\snot/, "ain't you")


    # use don't instead of doesn't or does not
    to_be_translated = to_be_translated.gsub(/[dD][oO][eE][sS][']*[nN][']*[tT]/, "don't")
    to_be_translated = to_be_translated.gsub(/[dD][oO][eE][sS]\s[nN][oO][tT]/, "don't")

    # what the hell -> what in the sphincter of hell
    to_be_translated = to_be_translated.gsub(/[wW][hH][aA][tT]\s[iI][nN]\s[tT][hH][eE]\s[hH][eE][lL]{2}/, "what in the sphincter of hell")

    # no ly on advectives
    to_be_translated = to_be_translated.gsub(/[lL][yY]/, "")

    #

    pretty_print(to_be_translated)
  end

  private # PRIVATE BELOW THIS LINE

  def pretty_print(text)
    text = text.downcase.capitalize
    text = text.gsub(/[.?!]\s([a-z])/) {|s| s.upcase}

    text
  end
end