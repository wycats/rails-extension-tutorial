

desc 'Create the templates'
task :build_templates => :environment do
  Template.transaction do
    Template.create :name => "store", :prefix => "layouts", :handler => "erb", :locale => "en",
        :format => "html", :source => File.read(RAILS_ROOT+"/lib/awesome_theme/lib/views/layouts/store.html.erb")
      
    Template.create :name => "index", :prefix => "products", :handler => "erb", :locale => "en",
        :format => "html", :source => File.read(RAILS_ROOT+"/lib/awesome_theme/lib/views/products/index.html.erb")
  end
end