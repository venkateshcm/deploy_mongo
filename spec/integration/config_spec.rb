require File.dirname(__FILE__) + '/../spec_helper'

module DeployMongo
  describe Config, "read couch db config" do
    it "should load hostname from mongodb.yml" do
      Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml').hostname.should == "localhost"
    end
  
    it "should load portnumber from mongodb.yml" do
      Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml').port.should == 27017
    end
  
    it "should load delta path" do
      Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml').delta_path.should == File.dirname(__FILE__) + "/../integration/deltas"
    end

    it "should load database name" do
      Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml').database.should == "test"
    end

    it "should load mongo shell path" do
      Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml').mongo_shell_path.should_not == ""
    end

    it "should merge config with passed in values" do
      config = Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml')
      config.merge_config("database"=>"db")
      config.database.should == "db"
    end

    it "should fail with an exception when config file is not found" do
      lambda { Config.create_from_file(File.dirname(__FILE__) + '/../couchdb1.yml') }.should raise_error()
    end

  end
end