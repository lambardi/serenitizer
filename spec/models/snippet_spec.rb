require 'spec_helper'

describe 'translation cases' do
  it 'should not matter if input is upper or lower case' do
    snippet = Snippet.new
    snippet.set_text("God Damn it! This THING DoES'Nt work. Are you NOT gOINg to FiX it?")
    snippet.translated.should == "Goram it! This bunger don't work. Ain't you goin' to fix it?"
  end

  it 'should capitalize the first letter of a new sentence' do
    snippet = Snippet.new
    snippet.set_text("here is a sentence. here is another one. what if we get crazy with punctuation? calm down! fine.")
    snippet.translated.should == "Here is a sentence. Here is another one. What if we get crazy with punctuation? Calm down! Fine."
  end

  it 'should replace thing with bunger' do
    snippet = Snippet.new
    snippet.set_text("What is that thing?")
    snippet.translated.should == "What is that bunger?"
  end
end

