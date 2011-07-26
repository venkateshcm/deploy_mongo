require File.dirname(__FILE__) + '/../spec_helper'

module DeployMongo
  
  describe DbSchema, "Manage Schema" do

    it "load schema document" do
      repository = mock(Repository)
      repository.should_receive(:get_schema).and_return({"_id"=>"special_key",'applied_deltas'=>[1,2]})
      schema = DbSchema.load_or_create(get_couchdb_config,repository)
      schema.applied_deltas.should == [1,2]
    end
  
    it "create if schema document does not exist" do
      repository = mock(Repository)
      repository.should_receive(:get_schema).ordered
      repository.should_receive(:save_schema).ordered
      repository.should_receive(:get_schema).ordered.and_return({"_id"=>"special_key",'applied_deltas'=>[]})
      schema = DbSchema.load_or_create(get_couchdb_config,repository)
      schema.applied_deltas.should == []
    end

    it "on completion update schema document" do
      schema_doc = {"_id"=>"special_key","type"=>"__schema__", 'applied_deltas'=>[]}
      updated_schema_doc = {"_id"=>"special_key","type"=>"__schema__", 'applied_deltas'=>[1]}
      repository = mock(Repository)
      repository.should_receive(:save_schema).ordered.with(updated_schema_doc)    
      repository.should_receive(:get_schema).ordered.and_return(updated_schema_doc)    
      schema = DbSchema.new(schema_doc,repository)
      schema.completed(Delta.new(1,'file_name','command','rollback_command'))
      schema.applied_deltas.should == [1]
    end

    it "on rollback update schema document" do
      schema_doc = {"_id"=>"special_key","type"=>"__schema__", 'applied_deltas'=>[1]}
      updated_schema_doc = {"_id"=>"special_key","type"=>"__schema__", 'applied_deltas'=>[]}
      repository = mock(Repository)
      repository.should_receive(:save_schema).ordered.with(updated_schema_doc)
      repository.should_receive(:get_schema).ordered.and_return(updated_schema_doc)    
      schema = DbSchema.new(schema_doc,repository)
      schema.rollback(Delta.new(1,'file_name','command','rollback_command'))
      schema.applied_deltas.should == []
    end
  
  end
end