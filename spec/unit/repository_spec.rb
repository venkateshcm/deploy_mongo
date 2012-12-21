require File.dirname(__FILE__) + '/../spec_helper'

module DeployMongo
  
  describe Repository, "execute a delta" do

        it "get schema document" do
           schema =  {"_id"=>"special_key","type"=>"__schema__", 'applied_deltas'=>[1,2], "type_versions"=>{"customer"=>10}}
           mock_server = mock(Mongo::Connection)
           Mongo::Connection.should_receive(:new).with("localhost",27017,:safe=>true).and_return(mock_server)
           mock_db = mock(Mongo::DB)
           mock_server.should_receive(:db).with("test").and_return(mock_db)
           mock_collection = mock(Mongo::Collection)
           mock_db.should_receive(:collection).with("schema").and_return(mock_collection)
           mock_collection.should_receive(:find_one).with("_id" => "schema__schema_document_key__").and_return(schema)
           repository = Repository.new(get_couchdb_config)
           rows = []
           repository.get_schema.should == schema
         
         end

         it "save schema document without id" do
            schema =  {"type"=>"__schema__", 'applied_deltas'=>[1,2], "type_versions"=>{"customer"=>10}}
            mock_server = mock(Mongo::Connection)
            Mongo::Connection.should_receive(:new).with("localhost",27017,:safe=>true).and_return(mock_server)
            mock_db = mock(Mongo::DB)
            mock_server.should_receive(:db).with("test").and_return(mock_db)
            mock_collection = mock(Mongo::Collection)
            mock_db.should_receive(:collection).with("schema").and_return(mock_collection)
            mock_collection.should_receive(:save).with(schema.merge("_id" => "schema__schema_document_key__")).and_return(schema)
            repository = Repository.new(get_couchdb_config)
            rows = []
            repository.save_schema(schema)

          end

          it "save schema document with id" do
             schema =  {"_id" => "schema__schema_document_key__", "type"=>"__schema__", 'applied_deltas'=>[1,2], "type_versions"=>{"customer"=>10}}
             mock_server = mock(Mongo::Connection)
             Mongo::Connection.should_receive(:new).with("localhost",27017,:safe=>true).and_return(mock_server)
             mock_db = mock(Mongo::DB)
             mock_server.should_receive(:db).with("test").and_return(mock_db)
             mock_collection = mock(Mongo::Collection)
             mock_db.should_receive(:collection).with("schema").and_return(mock_collection)
             mock_collection.should_receive(:save).with(schema).and_return(schema)
             repository = Repository.new(get_couchdb_config)
             rows = []
             repository.save_schema(schema)

           end



  end
  
end