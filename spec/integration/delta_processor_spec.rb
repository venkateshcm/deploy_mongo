require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/database_populator'

module DeployMongo
  
  describe DeltaProcessor, "integration" do  
  
    before :all do
      config = Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml')
      DatabasePopulator.new(config.database,config.mongo_shell_path).with_type("customer").with_records(30).build
    end
  
      
    it "integration load relavent documents and apply delta" do
      config = Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml')
      command = 'db.customer.update({},{$set: {"address":"some address"}},false,true)'
      rollback_command = 'db.customer.update({},{$unset: {"address":1}},false,true)'
      delta = Delta.new(1,'file_name',command,rollback_command)
      delta_processor = DeltaProcessor.new(config,delta)
      delta_processor.apply    
    end
    
    it "integration load relavent documents apply delta and rollback" do
      config = Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml')
      command = 'db.customer.update({},{$set: {"address":"some address"}},false,true)'
      rollback_command = 'db.customer.update({},{$unset: {"address":1}},false,true)'
      delta = Delta.new(1,'file_name',command,rollback_command)
      delta_processor = DeltaProcessor.new(config,delta)
      delta_processor.apply
          
      delta_processor.rollback
            
    end
  
  end
  
end