require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/database_populator'

module DeployMongo
  describe Repository, "execute a delta" do
  
    before :all do
      DatabasePopulator.new("test").with_type("customer").with_records(1).build
    end
    
   it "create schema document if it does not exist and get schema to verify" do
     config = Config.create_from_file(File.dirname(__FILE__) + '/../mongodb.yml')
     config.merge_config({"database"=>"test"})
     schema =  {"_id"=>"schema__schema_document_key__","type"=>"__schema__", 'applied_deltas'=>[], "type_versions"=>{}}
     repository = Repository.new(config)
     rows = []
     repository.save_schema(schema)
     schema_doc = repository.get_schema
     schema_doc['_id'].should == schema['_id']
     schema_doc['type'].should == schema['type']
     schema_doc['applied_deltas'].should == schema['applied_deltas']
     schema_doc['type_versions'].should == schema['type_versions']
    end

  end
  
end