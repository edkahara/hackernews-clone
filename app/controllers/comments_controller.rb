class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :set_commentable, only: [:create]
  before_action :authenticate_user!

  def index
    @comments = Comment.all.newest_first
  end

  def edit
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.parent_id = @comment.commentable_type == 'Submission' ? @commentable.id : @commentable.parent_id
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to :back }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to :back, notice: 'Comment was successfully updated.' }
        format.json { render json: @comment, status: :ok, location: @comment }
      else
        format.html { redirect_to :back }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @comment.liked_by current_user
    redirect_to :back
  end

  def unlike
    @comment.unliked_by current_user
    redirect_to :back
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_commentable
      @commentable = Comment.find(params[:comment_id]) if params[:comment_id]
      @commentable = Submission.find(params[:submission_id]) if params[:submission_id]
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
