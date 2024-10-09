module Export
  class CommentsController < ApplicationController
    def index
        comments = Comment.joins(:post).where(status: "public", comments: {status: "public"})
        respond_to do |format|
            format.csv { send_data comments.to_csv, filename: "comments-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"}
        end
    end
  end
end
