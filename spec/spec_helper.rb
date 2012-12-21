require 'rubygems'
require 'rspec'
require File.dirname(__FILE__) + '/../lib/deploy_mongo'


  def get_couchdb_config
    DeployMongo::Config.new({"hostname"=>"localhost","port"=>27017,"database"=>"test",'delta_path'=>"path/to/deltas","config_folder_path" => "/somefolder","doc_type_field"=>"type","type_version_field" => 'type_version','mongo_shell_path' =>"/usr/local/bin/mongo" })
  end
  
  def create_json_response(total_rows,num_of_records,offset=0)
    h = {"total_rows"=> total_rows,"offset" => offset, "rows" => []}
    (1..num_of_records).each do |x|
      h["rows"].push({"id"=>x})
    end
    JSON.generate(h)
  end

