class PushController < ApplicationController
	
	

	def index
		@post = Post.new
	end

	def new
		client = Parse.init :application_id => "TMV1qKmrO5FziiXahM5E4JnTT38VpewRmDtrSPNK", # required
         	         	    :api_key        => "FYKe6vQbP1AKZb2wuywnYGKl6yACu5LAPHSquxL6" # required

        
		data = { 
				 alert:"Your question was answered!",
				 title: "PhotoQ",
				 answer: params[:answer],
				 question: params[:question]
			
			   }
		push = Parse::Push.new(data, "global")
		query = Parse::Query.new(Parse::Protocol::CLASS_INSTALLATION).eq('user_id', params[:user_id])
		
		push.where = query.where
		push.save
		redirect_to root_path
	end

	private

	def post_params
		params.require(:post).permit(:question, :answer, :user_id)
	end
end
