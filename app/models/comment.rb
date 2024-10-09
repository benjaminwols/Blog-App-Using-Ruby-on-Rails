require 'csv'

class Comment < ApplicationRecord
  include Visible
  belongs_to :post

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Post title", "Comment author", "Comment body"]
      all.each do |comment|
        csv << [comment.post.title, comment.author, comment.body]
      end
    end
  end
end
