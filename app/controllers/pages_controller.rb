class PagesController < ApplicationController
	before_action :set_user, except: [:newest, :missing]

	def profile
		@karma = (@user.submissions.map{|s| s.get_upvotes.count}.sum) + (@user.comments.map{|c| c.get_upvotes.count}.sum)
	end

  def newest
    @submissions = Submission.all.newest_first
  end

	def user_submissions
		@user_submissions = @user.submissions.newest_first
	end

	def user_comments
		@user_comments = @user.comments.newest_first
	end

	def user_favorites
		@likes = @user.find_voted_items
		@liked_submissions = @likes.select { |i| i.class.name == "Submission" }
		@liked_comments = @likes.select { |i| i.class.name == "Comment" }
	end

	def missing
	end

	private
    def set_user
			if (User.find_by_username(params[:id]))
				@username = params[:id]
				@user = User.find_by_username(@username)
			else
				redirect_to missing_path, :notice => "User not found"
			end
    end
end
