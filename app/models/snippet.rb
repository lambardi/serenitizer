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

    to_be_translated = simple_single_words(to_be_translated)

    # use contractions
    to_be_translated = to_be_translated.gsub(/i\sam/, "i'm")

    # replace thing with bunger
    to_be_translated = to_be_translated.gsub(/thing/, "bunger")

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
    to_be_translated = to_be_translated.gsub(/(on){0}|(real){0}ly/, "")

    # irregular verbs default to third person singular
    to_be_translated = to_be_translated.gsub(/were/, "was")
    # cleanup 1
    to_be_translated = to_be_translated.gsub(/has\sto\sbe/, "h1as gotta be")
    to_be_translated = to_be_translated.gsub(/gets/, "got")

    # malformed verbs
    to_be_translated = to_be_translated.gsub(/grew/, "growed")
    to_be_translated = to_be_translated.gsub(/very well/, "real good")
    to_be_translated = to_be_translated.gsub(/came/, "come")
    to_be_translated = to_be_translated.gsub(/saw/, "seen")
    to_be_translated = to_be_translated.gsub(/has/, "done")
    to_be_translated = to_be_translated.gsub(/my/, "my own")
    to_be_translated = to_be_translated.gsub(/is\sgoing\sto/, "gone")

    # drop the 'g' on gerunds
    to_be_translated = to_be_translated.gsub(/ing\s/, "in'")

    # cleanup 1
    to_be_translated = to_be_translated.gsub(/h1as/, "has")

    pretty_print(to_be_translated)
  end

  private # PRIVATE BELOW THIS LINE

  def pretty_print(text)
    text = text.downcase.capitalize
    text = text.gsub(/[.?!]\s([a-z])/) {|s| s.upcase}

    text
  end

  def simple_single_words(text)
    # goram
    text = text.gsub(/god\sdam[mMnN]*/, "goram")

    # confound
    text = text.gsub(/confused/, "confounded")
    text = text.gsub(/confuse/, "confound")

    # chow
    text = text.gsub(/food/, "chow")

    text
  end
end