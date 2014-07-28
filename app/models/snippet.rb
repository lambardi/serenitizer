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
    text = self.text.downcase

    text = replace_simple_words(text)

    # use contractions
    text = text.gsub(/i\sam/, "i'm")

    # replace thing with bunger
    text = text.gsub(/thing/, "bunger")

    # use the word ain't
    text = text.gsub(/are[']*n[']*t/, "ain't")
    text = text.gsub(/are\snot/, "ain't")
    text = text.gsub(/are\syou\snot/, "ain't you")

    # use don't instead of doesn't or does not
    text = text.gsub(/does[']*n[']*t/, "don't")
    text = text.gsub(/does\snot/, "don't")

    text = replace_simple_phrases(text)

    # no ly on advectives
    text = text.gsub(/(on){0}|(real){0}ly/, "")

    # irregular verbs default to third person singular
    text = text.gsub(/were/, "was")
    # cleanup 1
    text = text.gsub(/has\sto\sbe/, "h1as gotta be")
    text = text.gsub(/gets/, "got")

    # malformed verbs
    text = malform_verbs(text)

    # drop the 'g' on gerunds
    text = text.gsub(/(ing)(\s|$)/, 'in ')

    # cleanup 1
    text = text.gsub(/h1as/, "has")

    pretty_print(text)
  end

  private # PRIVATE BELOW THIS LINE

  def pretty_print(text)
    text = text.downcase.capitalize
    text = text.gsub(/[.?!]\s([a-z])/) {|s| s.upcase}
    text = text.gsub(/\si\s/, " I ")

    text
  end

  def replace_simple_words(text)
    # goram
    text = text.gsub(/god\sdam[mMnN]*/, "goram")

    # confound
    text = text.gsub(/confused/, "confounded")
    text = text.gsub(/confuse/, "confound")

    # chow
    text = text.gsub(/food/, "chow")

    # ruttin
    text = text.gsub(/fucking/, "ruttin")
    text = text.gsub(/fuckin|fukkin/, "ruttin")

    text
  end

  def replace_simple_phrases(text)
    # what the hell -> what in the sphincter of hell
    text = text.gsub(/what\sthe\shell/, "what in the sphincter of hell")
    text = text.gsub(/what\sin\sthe\shell/, "what in the sphincter of hell")

    # i was not -> was i ever not
    text = text.gsub(/i\swas\snot/, "was i ever not")

    text
  end

  def malform_verbs(text)
    text = text.gsub(/grew/, "growed")
    text = text.gsub(/very well/, "real good")
    text = text.gsub(/came/, "come")
    text = text.gsub(/saw/, "seen")
    text = replace_has_state_with_done(text)
    text = text.gsub(/my/, "my own")
    text = text.gsub(/is\sgoing\sto/, "gone")

    text
  end

  def replace_has_state_with_done(text)
    states = ["been", "gotten", "happened", "occurred", "gone"]

    states.each do |state|
      regex = Regexp.new("has #{state}" )
      text = text.gsub(regex, "done #{state}")
    end

    text
  end
end