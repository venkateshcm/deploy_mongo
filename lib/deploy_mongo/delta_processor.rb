module DeployMongo

  class DeltaProcessor
    def initialize(config,delta)
      @delta = delta
      @config = config
    end
  
    def apply
      user_command = @delta.command.gsub("'","''")
      shell = MongoShell.new(@config.database)
      shell.execute(user_command)
    end
    
    def rollback
      user_rollback_command = @delta.rollback_command.gsub("'","''")
      shell = MongoShell.new(@config.database)
      shell.execute(user_rollback_command)
    end
  end
  
end