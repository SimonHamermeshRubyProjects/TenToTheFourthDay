class PagesController < ApplicationController
    def home
        @user = User.new
        
    end
    
    def create
         @user  = User.new(contact_params)
        if @user.save
            flash[:success] = 'Message sent.'
            redirect_to pages_path
         else
            flash[:danger] = 'Error occured, message has not been sent.'
            redirect_to root_path
        end
    end
    
     def index
         
        @user = User.last
    
     end
     
    def about
    end
    
    def overview
    
        @user = User.all
        
        respond_to do |format|
          format.html
          format.csv { render text: @user.to_csv }
        end
    
    end
      
    def import
        begin
        
            User.import(params[:file])
            flash[:success] = 'Users uploaded.'
            redirect_to overview_path
        rescue
            flash[:danger] = "Invalid CSV file."
            redirect_to overview_path    
        end  
    end
  


  private
    def contact_params
      params.require(:user).permit(:first_name,:last_name,:birthday)
    end

end
