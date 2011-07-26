require File.dirname(__FILE__) + '/../spec_helper'

module DeployMongo
  
  describe DeltaLoader, "load all delta" do

    it "should load all YAML files from the deltas folder" do
    
      command = "db.customer.update({},{$set: {\"address\": \"some address\" } } , false , true );\n\n" 
      rollback_command = "\n\ndb.customer.update({},{$unset: {\"address\": 1}},false,true);\n" 

      delta_loader = DeltaLoader.new(File.dirname(__FILE__)+'/deltas')
      deltas = delta_loader.get_deltas
      deltas.count.should == 5
      deltas[1].file_name.should == "1_add_address_to_customer.js"
      deltas[1].command.should == command
      deltas[1].rollback_command.should == rollback_command
    end
  
    it "should  raise an error when file is not in deltanumber_description format" do
      File.new(File.dirname(__FILE__)+'/deltas/invalid_delta_file.js','w')
      begin
        delta_loader = DeltaLoader.new(File.dirname(__FILE__)+'/deltas')
        lambda { delta_loader.get_deltas }.should raise_error()
      ensure
        File.delete(File.dirname(__FILE__)+'/deltas/invalid_delta_file.js')
      end    
    end
  
    it "should raise an error when two deltas have the same key" do
      File.new(File.dirname(__FILE__)+'/deltas/11_duplicate_key.js','w')
      begin
        delta_loader = DeltaLoader.new(File.dirname(__FILE__)+'/deltas')
        lambda { delta_loader.get_deltas }.should raise_error()
      ensure
        File.delete(File.dirname(__FILE__)+'/deltas/11_duplicate_key.js')
      end    
    
    end
  
    it "should raise an error when file content does not have both type and command" do
      File.new(File.dirname(__FILE__)+'/deltas/100_invalid_delta_file_content.js','w')
      begin
        delta_loader = DeltaLoader.new(File.dirname(__FILE__)+'/deltas')
        lambda { delta_loader.get_deltas }.should raise_error()
      ensure
        File.delete(File.dirname(__FILE__)+'/deltas/100_invalid_delta_file_content.js')
      end    
    end
  
  end
  
end