require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "to csv" do
    assert_equal(
      "Post title,Comment author,Comment body\nTitle1,Author,Body\n",
      posts(:one).comments.to_csv
    )
  end
end
