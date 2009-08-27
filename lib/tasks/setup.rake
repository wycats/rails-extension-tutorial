rails_root = File.join(File.dirname(__FILE__), "..", "..")

require "fileutils"

task :setup do
  puts "Copying database.yml"
  FileUtils.cp(File.join(rails_root, "config", "database.sample.yml"), 
    File.join(rails_root, "config", "database.yml"))
    
  puts "Copying development.sqlite3"
  FileUtils.cp(File.join(rails_root, "db", "default", "development.sqlite3"), 
    File.join(rails_root, "db", "development.sqlite3"))
  
  puts "Done."
end