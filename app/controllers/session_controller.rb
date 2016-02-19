class SessionController < ApplicationController

	require 'rest_client'
	
	def create 
		#endpoint = 'https://api.diuit.net/1/auth/nonce'

		#headers = {
		#	'x-diuit-application-id' => '60a3d6ea8105c9426969fd14a2a38845',
		#	'x-diuit-api-key' => '724b4289d769d4d7df9af5842fa49e5c'
		#}

		#@nonce = RestClient.get(endpoint,headers)

		render json: params
		return

		@user_email = parse(params[:useremail])

	end
end
