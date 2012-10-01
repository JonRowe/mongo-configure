require 'mongo/configure/uri'

describe 'parsing Mongo URIs' do
  describe 'falling back to defaults' do
    subject { Mongo::Configure::URI.new }
    its(:scheme)   { should == 'mongodb' }
    its(:host)     { should == 'localhost' }
    its(:port)     { should == '27017' }
    its(:database) { should == '' }
    its(:user)     { should == nil }
    its(:password) { should == nil }
    its(:to_s)     { should == 'mongodb://localhost:27017/' }
  end
  describe 'setting elements' do
    subject { Mongo::Configure::URI.new "secretsquirrel",'server.name','666','data','user','s3kr1t' }
    its(:scheme)   { should == 'secretsquirrel' }
    its(:host)     { should == 'server.name' }
    its(:port)     { should == '666' }
    its(:database) { should == 'data' }
    its(:user)     { should == 'user' }
    its(:password) { should == 's3kr1t' }
    its(:auth)     { should == 'user:s3kr1t@' }
    its(:to_s)     { should == 'secretsquirrel://user:s3kr1t@server.name:666/data' }
  end
  describe 'parsing a supplied uri' do
    subject { Mongo::Configure::URI.parse "secretsquirrel://user:s3kr1t@server.name:666/data" }
    its(:scheme)   { should == 'secretsquirrel' }
    its(:host)     { should == 'server.name' }
    its(:port)     { should == '666' }
    its(:database) { should == 'data' }
    its(:user)     { should == 'user' }
    its(:password) { should == 's3kr1t' }
    its(:auth)     { should == 'user:s3kr1t@' }
    its(:to_s)     { should == 'secretsquirrel://user:s3kr1t@server.name:666/data' }
  end
end
