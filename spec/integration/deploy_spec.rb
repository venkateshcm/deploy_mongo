require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/database_populator'

module DeployMongo
  
  describe Deploy, "load and execute deltas first database" do
  
    before :all do
      DatabasePopulator.new("test").with_type("customer").with_records(30).build
    end
  
    it "load and execute deltas" do    
      config = Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml')
      deploy = Deploy.new(config)
      deltas = deploy.run
      deltas.count.should == 5
      deltas[0].file_name.should == "1_add_address_to_customer.js"    
    end
  end
  
  
  describe Deploy, "execute deltas and rollback all deltas" do
  
    before :all do
      DatabasePopulator.new("test").with_type("customer").with_records(30).build
    end
  
    it "load and execute deltas" do    
      config = Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml')
      deploy = Deploy.new(config)
      deploy.run      
      deltas = deploy.rollback
      deltas.count.should == 5
      deltas[0].file_name.should == "13_copy_and_create_new_customer.js"    
    end
  end

  describe Deploy, "execute deltas and rollback only 2 deltas" do
  
    before :all do
      DatabasePopulator.new("test").with_type("customer").with_records(30).build
    end
  
    it "load and execute deltas" do    
      config = Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml')
      deploy = Deploy.new(config)
      deploy.run      
      deltas = deploy.rollback(2)
      deltas.count.should == 2
      deltas[0].file_name.should == "13_copy_and_create_new_customer.js"    
      deltas[1].file_name.should == "12_delete_customer_name_1.js"    
    end
  end



end