require "test_helper"
require "csv"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "export with visible comments" do
    get comments_export_path
    assert_response :success
    assert_equal("text/csv", response.header["Content-Type"])

    rows = CSV.parse(response.body, headers: true)
    assert_equal(rows.headers, ["post title", "comment author", "comment body"])

    # Make sure that only the visible comments of visible posts are returned
    assert_equal(rows.length, 2)

    [comments(:one), comments(:two)].each do |expected_comment|
      assert(rows.any? do |row| 
        row["post title"] == expected_comment.post.title and
        row["comment author"] == expected_comment.author and
        row["comment body"] == expected_comment.body
      end)
    end
  end

  test "export without visible comments" do
    comments(:one).delete()
    comments(:two).delete()

    get comments_export_path

    rows = CSV.parse(response.body, headers: true)
    assert_equal(rows.headers, ["post title", "comment author", "comment body"])

    assert_equal(rows.length, 0)
  end
end
