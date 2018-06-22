class NotesController < ApplicationController

    def index 
    end 

    def show 
    end 

    def new 
        @note = Note.new 
    end 

    def create 
        @user = User.find_by(id: session[:user_id])
        @note = Note.create(content: params[:note][:content], user_id: @user.id)

        render json: @note, status: 201
    end 

    def edit 
    end 

    def update 
    end 

    def destroy
        @note = Note.find_by(id: params[:id])
        @id = @note.id
        @note.destroy

        render json: @id, status: 201
    end 

end
