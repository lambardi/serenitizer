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
    to_be_translated = to_be_translated.gsub(/god\sdam[mMnN]*/, "goram")

    # replace thing with bunger
    to_be_translated = to_be_translated.gsub(/thing/, "bunger")

    # drop the 'g' on gerunds
    to_be_translated = to_be_translated.gsub(/ing/, "in'")

    # use the word ain't
    to_be_translated = to_be_translated.gsub(/are[']*n[']*t/, "ain't")
    to_be_translated = to_be_translated.gsub(/are\snot/, "ain't")
    to_be_translated = to_be_translated.gsub(/are\syou\snot/, "ain't you")


    # use don't instead of doesn't or does not
    to_be_translated = to_be_translated.gsub(/does[']*n[']*t/, "don't")
    to_be_translated = to_be_translated.gsub(/does\snot/, "don't")

    # what the hell -> what in the sphincter of hell
    to_be_translated = to_be_translated.gsub(/what\sin\sthe\shell/, "what in the sphincter of hell")

    # no ly on advectives
    to_be_translated = to_be_translated.gsub(/ly/, "")

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