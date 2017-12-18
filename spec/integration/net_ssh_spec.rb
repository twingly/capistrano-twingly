require "net/ssh"

RSpec.describe Net::SSH do
  it "supports the ed25519 algorithm" do
    expect(Net::SSH::Authentication::ED25519Loader::LOADED).to be(true)
  end
end
