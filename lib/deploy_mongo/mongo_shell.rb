module DeployMongo
    class MongoShell

      def initialize(database)
        @database = database
      end
  
      def execute(command)
        command = command.gsub("'","''")
        mongo_command = "/Users/admin/work/mongodb-osx-x86_64-1.8.2/bin/mongo #{@database} --eval '#{command}'"
        #puts mongo_command
        `#{mongo_command}`
        raise "error"  if ($?.to_i != 0)
      end

    end
end