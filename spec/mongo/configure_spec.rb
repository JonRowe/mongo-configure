require 'mongo/configure'

describe 'configuring databases' do
  describe 'from a uri' do
    subject do
      Mongo::Configure.from_uri('secretsquirrel://server.name:666/data').uri
    end
    its(:scheme)   { should == 'secretsquirrel' }
    its(:host)     { should == 'server.name' }
    its(:port)     { should == '666' }
    its(:database) { should == 'data' }
    its(:auth)     { should == '' }
    its(:to_s)     { should == 'secretsquirrel://server.name:666/data' }

    context "with authentication" do
      subject do
        Mongo::Configure.from_uri('secretsquirrel://squirrel:s3krit@server.name:666/data').uri
      end
      its(:user)     { should == 'squirrel' }
      its(:password) { should == 's3krit' }
      its(:auth)     { should == 'squirrel:s3krit@' }
      its(:to_s)     { should == 'secretsquirrel://squirrel:s3krit@server.name:666/data' }
    end
  end

  describe "configuration via database name" do
    subject do
      Mongo::Configure.from_database("test").uri
    end
    its(:scheme)   { should == 'mongodb' }
    its(:host)     { should == 'localhost' }
    its(:port)     { should == '27017' }
    its(:database) { should == 'test' }
    its(:to_s)     { should == 'mongodb://localhost:27017/test' }
  end

  describe 'accessing a configuration' do
    let!(:configuration) { Mongo::Configure.from_database("test") }
    subject { Mongo::Configure.current }
    it { should == configuration }
  end

  describe 'loading a connection from the configuration' do
    let(:configuration)   { Mongo::Configure.current }
    let(:fake_connector)  { double :from_uri => fake_connection }
    let(:fake_connection) { double :db => database }
    let(:database)        { double }

    before do
      Mongo::Configure.from_uri 'secretsquirrel://server.name:666/data'
      configuration.connection = fake_connector
    end

    subject { configuration.load }

    it "loads the database from uri" do
      fake_connector.should_receive(:from_uri).with 'secretsquirrel://server.name:666/data'
      subject
    end
    it "gets the database named" do
      fake_connection.should_receive(:db).with "data"
      subject
    end
    it { should == database }
  end
end
