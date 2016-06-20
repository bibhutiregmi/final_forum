class Post < ActiveRecord::Base

	validates :title, :content, :presence => true
	validates :title, :length => { :minimum => 2 }
	validates :title, :uniqueness => true

	belongs_to :user
	has_many :comments

#   def self.search(search)
#   if search
#     Post.find(:title, :conditions => ['name LIKE ?', "%#{search}%"])
#   else
#     Post.find(:title)
#   end
# end


  def self.search(search)

    where("title LIKE ?", "%#{search}%")
    # where("content LIKE ?", "%#{search}%")

  end

end
