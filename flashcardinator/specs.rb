require 'rspec'
require './card.rb'
require './deck.rb'
require './ui.rb'

describe Card do
  let(:card) { Card.new("foo", "some weird programming word") }

  describe "#term" do
    it "returns the term associated with the card" do
      card.term.should eq("foo")
    end
  end

  describe "#definition" do
    it "returns the definition for the card" do
      card.definition.should eq("some weird programming word")
    end
  end
end

describe UI do
  describe ".guess" do
    before(:each) do
      @output = StringIO.new
      $stdout = @output

      STDIN.stub!(:gets).and_return("true")
    end

    it "prompts the user" do
      UI.guess
      @output.rewind
      @output.read.should =~ /give a guess/i
    end

    # it "works for valid input" do
    #   STDIN.stub(:gets).and_return('true')
    #   UI.guess.should be_an_instance_of Guess
    # end

    context "when guess is correct" do
      it "prints out positive feedback" do
        UI.guess
        @output.rewind
        @output.read.should =~ /good answer!/i
      end
    end

    context "when guess is wrong" do
      before(:each) { STDIN.stub!(:gets).and_return('false') }

      it "prints out negative feedback" do
        UI.guess
        @output.rewind
        @output.read.should =~ /wrong answer!/i
      end
    end

    after(:each) do 
      $stdout = STDOUT
    end
  end
end