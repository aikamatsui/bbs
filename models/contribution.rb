ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")
class Contribution < ActiveRecord::Base
has_many :replies
end

class Reply < ActiveRecord::Base
  belongs_to :contributions
end

class Category < ActiveRecord::Base
  has_many :items
end

class Categories < ActiveRecord::Base
has_many :contributions
end
