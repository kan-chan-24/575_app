class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: '投稿が作成されました'
    else
      render :new  # 保存失敗時は new ビューを再表示
    end
  end

  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      redirect_to @post, notice: '投稿を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])  # 削除する投稿を取得
    @post.destroy  # 削除実行
    redirect_to posts_path, notice: '投稿を削除しました', status: :see_other  # 一覧ページにリダイレクト
  end

  private

  def post_params
    params.require(:post).permit(:top, :middle, :bottom)
  end
end
