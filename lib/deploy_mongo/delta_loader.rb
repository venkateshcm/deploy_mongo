module DeployMongo

  class DeltaLoader
    def initialize(deltas_folder)
      @deltas_folder = deltas_folder
    end
  
    def get_deltas
      hash = {}
      files = Dir["#{@deltas_folder}/*.js"].select {|f| File.file?(f)}
      files.each do |file|
        file_name = File.basename(file)
        key = file_name.split('_')[0].to_i
        if (key == 0) 
          e = RuntimeError.new("invalid file name #{file_name}")
          raise e
        end
        if (hash.has_key?(key)) 
          e = RuntimeError.new("duplicate key found in file #{file_name}")
          raise e
        end
      
        hash[key] = convert_to_delta(key,file) 
      end
      hash
    end
  
    def convert_to_delta(id, file)
      file = File.open(file, "rb")
      contents = file.read
      file.close
      command = ''
      rollback_command = ''
      commands = contents.split('//@undo')
      raise "#{file_name} content is not valid " if commands.count == 0
      command = commands[0]
      rollback_command = commands[1] if commands[1]
      
      file_name = File.basename(file)
      Delta.new(id,file_name,command,rollback_command)
    end
  
  end

end