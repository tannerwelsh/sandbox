require_relative 'spec_helper'

describe Pneumatic::Client do
  let(:defaults) { Pneumatic::DEFAULTS }
  
  describe "#initialize" do
    it "attempts to establish a connection to a socket" do
      TCPSocket.stub(:open).and_return(true)
      TCPSocket.should_receive(:open)
      Pneumatic::Client.new(defaults)
    end
  end
end