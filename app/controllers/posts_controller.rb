class PostsController < ApplicationController
  before_action :authenticate_user! # Asegura que el usuario esté autenticado para todas las acciones
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.where.not(user_id: nil)
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post creado exitosamente!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "¡Post actualizado exitosamente!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "¡El post ha sido eliminado!"
    else
      flash[:error] = "Hubo un problema al eliminar el post."
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :description)
  end

  def set_post
    @post = Post.find_by(id: params[:id]) # Usar find_by para evitar excepciones si el post no existe
    unless @post
      flash[:alert] = "El post no fue encontrado."
      redirect_to posts_path
    end
  end

  def authorize_user!
    unless @post.user == current_user
      flash[:alert] = "No tienes permiso para realizar esta acción."
      redirect_to posts_path
    end
  end
end
