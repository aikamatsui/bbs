require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class  Task< ActiveRecord::Base
validates:title,
presence: true
end
class Contribution < ActiveRecord::Base
  belongs_to :category
end

class List < ActiveRecord::Base
end

class Categories < ActiveRecord::Base
has_many :contributions
end