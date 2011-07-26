module DeployMongo

  class Delta
    def initialize(id,file_name,command,rollback_command)
      @id=id
      @file_name = file_name
      @command = command
      @rollback_command = rollback_command
    end

    def id
      @id
    end

  
    def file_name
      @file_name
    end
  
    def command
      @command
    end

    def rollback_command
      @rollback_command
    end

  
  end

end