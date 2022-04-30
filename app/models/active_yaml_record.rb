class ActiveYamlRecord < ActiveYaml::Base
  set_root_path Rails.root.join('db/fixtures')
  include ActiveHash::Associations
end
