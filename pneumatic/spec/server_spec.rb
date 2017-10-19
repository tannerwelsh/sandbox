require_relative 'spec_helper'

describe Pneumatic::Server do
  let(:server) { Pneumatic::Server.new }
  let(:mock_server) { double('server') }

  describe "#initialize" do
    context "with default options" do
      it "starts listening on the default host and port" do
        expect {
          server
        }.to change {
          SocketHelper.is_open?(Pneumatic::DEFAULTS)
        }.from(false).to(true)
      end
    end
  end 

  describe "#start" do
    after(:each) { server.stop }

    it "allows connections from clients" do
      expect {
        server.start
      }.to change { 
        server.can_connect?      
      }.from(false).to(true)
    end
  end

  describe "#stop" do
    it "blocks any new incoming connections, disallowing new messages" do
      server.start
      expect {
        server.stop
        sleep 0.1
      }.to change {
        server.can_connect?
      }.from(true).to(false) 
      # expect { server.message "message" }.to raise_error Pneumatic::ClosedServerError
    end
  end
end
