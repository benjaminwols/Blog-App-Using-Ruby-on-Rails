class CommentsController < ApplicationController
    require 'csv'

    def new
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new
    end

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        if @comment.save
            redirect_to post_path(@post)
        else
            render :new, status: :unprocessable_entity
        end
    end

    # Sends a CSV file containing an export of all visible comments of visible posts, ordered 
    # ascendingly by the time of the comments' creation, with three columns: 
    # "post title", "comment author", "comment body"
    def export
        current_datetime_string = DateTime.now.utc.strftime("%Y-%d-%m_%H-%M-%S")

        send_data generate_export_csv,
            filename: "all_comments_export_#{current_datetime_string}.csv",
            type: "text/csv"
    end

    private

    def comment_params
        params.require(:comment).permit(:author, :body, :status)
    end

    def generate_export_csv
        header_row = ["post title", "comment author", "comment body"]

        data_rows = Comment
            .joins(:post)
            .where.not('comments.status': 'archived')
            .where.not('posts.status': 'archived')
            .order('comments.created_at': :asc)
            .pluck(:'posts.title', :'comments.author', :'comments.body')

        CSV.generate do |csv|
            csv << header_row
            data_rows.each { |row| csv << row }
        end
    end
end
