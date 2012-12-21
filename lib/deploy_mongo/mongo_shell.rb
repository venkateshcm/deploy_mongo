module DeployMongo
    class MongoShell

      def initialize(database,mongo_shell_path)
        @database = database
        @mongo_shell_path = mongo_shell_path
      end
  
      def execute(command)
        command = command.gsub("'","''")
        mongo_command = "#{@mongo_shell_path} #{@database} --eval '#{command}'"
        #puts mongo_command
        `#{mongo_command}`
        raise "error"  if ($?.to_i != 0)
      end

    end
end