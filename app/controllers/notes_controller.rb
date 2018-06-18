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
        @note.save

        render json: @user
    end 

    def edit 
    end 

    def update 
    end 

    def destroy 
    end 

end
