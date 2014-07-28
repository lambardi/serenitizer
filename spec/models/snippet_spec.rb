require 'spec_helper'

describe 'translation cases' do
  it 'should not matter if input is upper or lower case' do
    snippet = Snippet.new
    snippet.set_text("God Damn it! This THING DoES'Nt work. Are you NOT gOINg to FiX it?")
    snippet.translated.should == "Goram it! This bunger don't work. Ain't you goin to fix it?"
  end

  it 'should capitalize the first letter of a new sentence' do
    snippet = Snippet.new
    snippet.set_text("here is a sentence. here is another one. what if we get crazy with punctuation? calm down! fine.")
    snippet.translated.should == "Here is a sentence. Here is another one. What if we get crazy with punctuation? Calm down! Fine."
  end

  describe 'default irregular verbs to third person singular' do
    it 'should use was instead of were' do
      snippet = Snippet.new
      snippet.set_text("We were going there.")
      snippet.translated.should == "We was goin there."
    end

    it 'should use got instead of gets' do
      snippet = Snippet.new
      snippet.set_text("He gets none of that.")
      snippet.translated.should == "He got none of that."
    end

    it 'should use has got instead of got' do
      snippet = Snippet.new
      snippet.set_text("That has to be the problem")
      snippet.translated.should == "That has gotta be the problem"
    end
  end

  describe 'use malformed verbs' do
    it 'should use growed up real good' do
      snippet = Snippet.new
      snippet.set_text("He grew up very well.")
      snippet.translated.should == "He growed up real good."
    end

    it 'should use come instead of came' do
      snippet = Snippet.new
      snippet.set_text("He came by here last night.")
      snippet.translated.should == "He come by here last night."
    end

    it 'should use seen it and my own' do
      snippet = Snippet.new
      snippet.set_text("I saw it with my eyes.")
      snippet.translated.should == "I seen it with my own eyes."
    end

    it 'should use done instead of has and then a state of being' do
      snippet = Snippet.new
      snippet.set_text("This has been said many times. This has been fun.")
      snippet.translated.should == "This done been said many times. This done been fun."
    end

    it 'should use gone' do
      snippet = Snippet.new
      snippet.set_text("This is going to hurt.")
      snippet.translated.should == "This gone hurt."
    end
  end

  describe 'simple single word replacements' do
    it 'should use goram' do
      snippet = Snippet.new
      snippet.set_text("God damn, that is hot!")
      snippet.translated.should == "Goram, that is hot!"
    end

    it 'should use confound' do
      snippet = Snippet.new
      snippet.set_text("I am confused")
      snippet.translated.should == "I'm confounded"
    end

    it 'should use chow' do
      snippet = Snippet.new
      snippet.set_text("If you're hungry, there's food in the kitchen")
      snippet.translated.should == "If you're hungry, there's chow in the kitchen"
    end

    it 'should use ruttin' do
      snippet = Snippet.new
      snippet.set_text("This is fucking stupid. I fuckin hate this fukkin idea.")
      snippet.translated.should == "This is ruttin stupid. I ruttin hate this ruttin idea."
    end

    it 'should replace thing with bunger' do
      snippet = Snippet.new
      snippet.set_text("What is that thing?")
      snippet.translated.should == "What is that bunger?"
    end
  end

  describe 'simple phrase replacement' do
    it 'should i was never with was i ever not' do
      snippet = Snippet.new
      snippet.set_text("I was not asking how the captain feels.")
      snippet.translated.should == "Was I ever not askin how the captain feels."
    end
  end
end

