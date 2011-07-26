module DeployMongo

  class Repository
    PAGE_SIZE = 10
  
    def initialize(couch_config)
      @config = couch_config
    end
  
    def get_schema
      db = Mongo::Connection.new(@config.hostname,@config.port).db(@config.database)
      schema = db.collection("schema").find_one("_id" => "schema__schema_document_key__")
      schema
    end

    def save_schema(json)
      db = Mongo::Connection.new(@config.hostname,@config.port).db(@config.database)
      json = json.merge("_id" => "schema__schema_document_key__")
      db.collection("schema").save(json)
    end
  end
  
end