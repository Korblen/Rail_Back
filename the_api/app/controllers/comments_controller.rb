class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: %i[update destroy]
  # If you need authentication: 
  before_action :authenticate_user! , only: %i[ create]
  before_action :authorize_user!, only: %i[ update destroy]

  # GET /articles/:article_id/comments
  def index
    @comments = @article.comments.includes(:user) # Eager load user to avoid N+1 queries
    render json: @comments
  end

  # GET /articles/:article_id/comments/:id
  def show
    @comment = @article.comments.find(params[:id])
    render json: @comment
  end

  # POST /articles/:article_id/comments
  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user # Associate the comment with the current user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
  end


  private

  def set_article
    @article = Article.find(params[:article_id])
  end
  
  # Strong params
  def comment_params
    params.require(:comment).permit(:content, :article_id) # Remove :user_id, it's set automatically
  end

  def authorize_user!
    unless current_user == @comment.user
      render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
    end
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end
end
