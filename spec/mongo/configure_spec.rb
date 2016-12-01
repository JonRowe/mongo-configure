require 'mongo/configure'

RSpec.describe 'configuring databases' do
  describe 'from a uri' do
    let(:config) { Mongo::Configure.from_uri('secretsquirrel://server.name:666/data').uri }

    example { expect(config.scheme).to   eq 'secretsquirrel' }
    example { expect(config.host).to     eq 'server.name' }
    example { expect(config.port).to     eq '666' }
    example { expect(config.database).to eq 'data' }
    example { expect(config.auth).to     eq '' }
    example { expect(config.to_s).to     eq 'secretsquirrel://server.name:666/data' }

    context "with authentication" do
      let(:config) { Mongo::Configure.from_uri('secretsquirrel://squirrel:s3krit@server.name:666/data').uri }

      example { expect(config.user).to     eq 'squirrel' }
      example { expect(config.password).to eq 's3krit' }
      example { expect(config.auth).to     eq 'squirrel:s3krit@' }
      example { expect(config.to_s).to     eq 'secretsquirrel://squirrel:s3krit@server.name:666/data' }
    end
  end

  describe "configuration via database name" do
    let(:config) { Mongo::Configure.from_database("test").uri }

    example { expect(config.scheme).to   eq 'mongodb' }
    example { expect(config.host).to     eq 'localhost' }
    example { expect(config.port).to     eq '27017' }
    example { expect(config.database).to eq 'test' }
    example { expect(config.to_s).to     eq 'mongodb://localhost:27017/test' }
  end

  describe 'accessing an existing configuration' do
    it "will create a configuration when one doesn't exist" do
      Mongo::Configure.instance_variable_set('@config',nil)
      expect(Mongo::Configure.current).to be_a Mongo::Configure::Config
    end

    it "will present the last configuration when one does exist" do
      configuration = Mongo::Configure.from_database("test")
      expect(Mongo::Configure.current).to eq configuration
    end
  end

  describe 'loading a connection from the configuration' do
    let(:configuration)   { Mongo::Configure.current }

    before do
      Mongo::Logger.level = Logger::ERROR
      Mongo::Configure.from_uri 'mongodb://127.0.0.1:27017/test'
    end

    it 'loads the database from config and returns the database' do
      expect(configuration.load).to be_a Mongo::Database
    end
  end
end
