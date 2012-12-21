module DeployMongo
  class DatabasePopulator
    def initialize(database,mongo_shell_path)
      @database = database
      @mongo_shell_path = mongo_shell_path
    end
  
    def with_type(doc_type)
      @doc_type = doc_type
      self
    end
  
    def with_records(no_of_records)
      @no_of_records = no_of_records
      self
    end
  
    def build
      mongo_shell = MongoShell.new(@database,@mongo_shell_path)
      mongo_shell.execute("db.dropDatabase();")
      (1..@no_of_records).each do |i|
        h = {"name"=> "name_#{i}","type"=>@doc_type}
        json = JSON.generate(h)
        mongo_shell.execute("db.#{@doc_type}.save(#{json})")
      end
    end    
  end

end