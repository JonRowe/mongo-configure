require 'mongo/configure/uri'

describe 'parsing Mongo URIs' do
  describe 'falling back to defaults' do
    let(:uri) { Mongo::Configure::URI.new }
    it "sets scheme" do
      expect(uri.scheme).to eq 'mongodb'
    end
    it "sets host" do
      expect(uri.host).to eq 'localhost'
    end
    it "sets port" do
      expect(uri.port).to eq '27017'
    end
    it "sets database" do
      expect(uri.database).to eq ''
    end
    it "sets user" do
      expect(uri.user).to eq nil
    end
    it "sets password" do
      expect(uri.password).to eq nil
    end
    it "sets to_s" do
      expect(uri.to_s).to eq 'mongodb://localhost:27017/'
    end
  end
  describe 'setting elements' do
    let(:uri) { Mongo::Configure::URI.new "secretsquirrel",'server.name','666','data','user','s3kr1t' }
    it "sets scheme" do
      expect(uri.scheme).to eq 'secretsquirrel'
    end
    it "sets host" do
      expect(uri.host).to eq 'server.name'
    end
    it "sets port" do
      expect(uri.port).to eq '666'
    end
    it "sets database" do
      expect(uri.database).to eq 'data'
    end
    it "sets user" do
      expect(uri.user).to eq 'user'
    end
    it "sets password" do
      expect(uri.password).to eq 's3kr1t'
    end
    it "sets auth" do
      expect(uri.auth).to eq 'user:s3kr1t@'
    end
    it "sets to_s" do
      expect(uri.to_s).to eq 'secretsquirrel://user:s3kr1t@server.name:666/data'
    end
  end
  describe 'parsing a supplied uri' do
    let(:uri) { Mongo::Configure::URI.parse "secretsquirrel://user:s3kr1t@server.name:666/data" }
    it "sets scheme" do
      expect(uri.scheme).to eq 'secretsquirrel'
    end
    it "sets host" do
      expect(uri.host).to eq 'server.name'
    end
    it "sets port" do
      expect(uri.port).to eq '666'
    end
    it "sets database" do
      expect(uri.database).to eq 'data'
    end
    it "sets user" do
      expect(uri.user).to eq 'user'
    end
    it "sets password" do
      expect(uri.password).to eq 's3kr1t'
    end
    it "sets auth" do
      expect(uri.auth).to eq 'user:s3kr1t@'
    end
    it "sets to_s" do
      expect(uri.to_s).to eq 'secretsquirrel://user:s3kr1t@server.name:666/data'
    end
  end
end
