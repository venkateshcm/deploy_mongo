require File.dirname(__FILE__) + '/../spec_helper'

module DeployMongo
  
  describe DeltaProcessor, "execute a delta" do
    it "should apply delta" do
      mock_shell = mock(MongoShell)
      MongoShell.should_receive(:new).with('test').and_return(mock_shell)
      
      command= 'db.customer.update({},{$set: {"address": "some address" } } , false , true )'
      rollback_command= 'db.customer.update({},{$unset: {"address": 1}},false,true)'
      
      mock_shell.should_receive(:execute).with(command)
      delta = Delta.new(1,'file_name',command,rollback_command)
      next_type_version = 1
      delta_processor = DeltaProcessor.new(get_couchdb_config,delta)
      delta_processor.apply
    end

    it "should rollback delta" do
      mock_shell = mock(MongoShell)
      MongoShell.should_receive(:new).with('test').and_return(mock_shell)
      
      command= 'db.customer.update({},{$set: {"address": "some address" } } , false , true )'
      rollback_command= 'db.customer.update({},{$unset: {"address": 1}},false,true)'
      
      mock_shell.should_receive(:execute).with(rollback_command)
      delta = Delta.new(1,'file_name',command,rollback_command)
      next_type_version = 1
      delta_processor = DeltaProcessor.new(get_couchdb_config,delta)
      delta_processor.rollback
    end



  end

end