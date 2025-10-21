class CommentsController < ApplicationController

    before_action :set_movie

    before_action :set_comment, only: :destroy

    def create

        @comment = @movie.comments.build(comment_params)

        if user_signed_in?
            @comment.user = current_user
            @comment.name = current_user.display_name.presence || current_user.email
        end

        if @comment.save
            redirect_to @movie, notice: "Comentario publicado!!!"
        else
            @comments = @movie.comments
            flash.now[:alert] = "Não foi possivel publicar seu comentario"
            render "movies/show", status: :unprocessable_entity
        end
    end

    def destroy
        unless can_delete_comment?(@comment)
            return redirect_to @movie, alert: "Você não pode apagar esse comentário"
        end

        @comment.destroy
        redirect_to @movie, notice: "Comentario retirado"
    end

    private

    def set_movie
        @movie = Movie.find(params[:movie_id])
    end

    def set_comment
        @comment = @movie.comments.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:name, :content)
    end

    def can_delete_comment?(comment)
        return false unless user_signed_in?
        comment.user == current_user || @movie.user == current_user
    end
end