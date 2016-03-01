class SessionController < ApplicationController
skip_before_action :verify_authenticity_token

	require 'rest_client'
	require 'jwt'

	def create 
		endpoint = 'https://api.diuit.net/1/auth/nonce'

		headers = {
			'x-diuit-application-id' => '60a3d6ea8105c9426969fd14a2a38845',
			'x-diuit-api-key' => '724b4289d769d4d7df9af5842fa49e5c'
		}

		@nonce = RestClient.get(endpoint,headers)

		#@user_email = params[:useremail]
		#@user_device_id = params[:userdeviceid]

		#render json:params

		exp = Time.now.to_i + 4 * 3600
		iss = '60a3d6ea8105c9426969fd14a2a38845'
		iat = Time.now.to_i
		sub = 'leowang@buylubechemical.com'
		nce = @nonce

		@hash = {
			"header" => {
				"typ" => "JWT",
				"alg" => "RS256",
				"cty" => "diuit-eit;v=1",
				"kid" => "c6e1c6f5402e49ae6db74005bca65c55"
			},

			"payload" => {
				"exp" => exp,
				"iss" => iss,
				"iat" => iat,
				"sub" => sub,
				"nce" => nce
			}
		}

		rsa_private = "-----BEGIN RSA PRIVATE KEY-----
		MIIEogIBAAKCAQEAh4v/dysivcJWD6gt56nV0Yp3n5XfieVeRvWP8spuxKA5xARLVtYZ0H8W
		uDxKBcgA9cJSLqTl7Z16pcCueJwyHKLBe5WSuLQt1ay90Tzh1EAglGnruE3DEOl01guakwOd
		TDKlZ2f7VumTBb95nF6PuXRkN652paqb97Vmc54/Xv8HAtUX4chxwoZHPIORiF6tMc8uW/Ue
		A7KrKAcp5dt5JKVA7MXJUVqyr8WxZctGMQxvUU3Twakt2gfV3ytzYgHRYkT7rKjvLTwCEnrQ
		SANPtm8a+wbHpuC9W7Bwn1yqzDtb+TSUXODBKRjGLVB8hKoxVafqPIkwe26Xc1/YXNOyoQID
		AQABAoIBAGD54IQ58FkjOL9q66za7YdFMeCTMaNO3uyVs69Y9Xbny2xaRiyScVWiF3coay1H
		sqghpvqIL5iZGq6L9EeGOLQUHal1kctj3YcKV6Pjkw5v8t88CNGLkQwAev7IvoaAB4IEmiIp
		WsELy4xJOZCOdvWQOEM+JtTQA1ZuCiaeCWjEsmDkXrsmQx03rkvULVQjrZNIcyUIxQnhIzME
		aZlRT2TibXugqf8u26tCpoMEwxvvAI4Cyp7BIue0WwjD7G7tw2LtdxiDckVCn4gbuyOUO75x
		jHhh6WsJWWbh0wCePIdDe+qemkLKh31P0LlW9yjHYaQm6xBa8AyTNqBiE7ZUzyECgYEAwO/U
		zXWsXiA1IMLhPfoDKggEIqy0GCKJzWj0RX/DyaWuxKsGLMU7wvB8xm7WpJtFwmxwRDC+75gi
		SuYMMV6VuIgRZA4DxBLK9/cB9ly3CfkwSL8FRqMCDzeWSTJ0BVba2o3HG0X22YKDOj6eeWbT
		Up4YZeUmr4bmsHsqFRKwb+MCgYEAs9oB6Kwde+AxueouIpc3/glk+joWNOgofTGwPaV/dj5D
		08FuVrTH6cucgken2sGpV7GGX/3fW7ExkoBmeB2S3vl4gYeGfabik9rELdRTkgfzVCrkiQZj
		Wfif2AElox0PEkSgmAzMPBUND9XYDbArowhoFFp/MsXzo8W2uSdpEqsCgYBCqBlLSqZcdqAk
		2/qK6BAOzjCigxGclhNoT8Ta8rGtfkldTjS6ul0tgVFwTFi+Uomm7RFutmciWD/o27+94Ce
		mlP3z2e5rAx3kt0YsnuCdJcb6vL1roednkTL0SSIW7OM4oKxh4B7MT4JN20k4EOOPZSMT5kH
		94Fn44VsdmKCpQKBgALGQy9GsHG/xKSckzefY5K8rF0b1kncpvs/b/uTeQLm9P7oRf56bXcS
		2Ag+eL1sLWOX7n2+mdp9QkmDR5Fky2Y7LPu6jn2TvH0Ra+NVGjDvhHZw7vOaMKArsLORWPZK
		NXhPrLaLw/7NSFVNNDcJ17J9J7Xgq4OqABcvrqDulbVfAoGAWmW1rjS3fmXlDfIsu48QkZ81
		lcqV7/pAWkhcFOyy5NZXKlav/WHyJ5uyjlAqwnxQj4tUDEnYXhLNYTycMEOi4Gu4dGjpzd5e
		yOXVpNBoei3oucHqPB7inTAigCAo+y8sJEr6y7O0TkFwQlZDcCbVwZFun/3jPy1CUau68Geh
		1zM=
		-----END RSA PRIVATE KEY-----
		"		
		@token = JWT.encode @hash, rsa_private

		render @token
		post_request ={
			:headers => {
				'x-diuit-application-id' => '60a3d6ea8105c9426969fd14a2a38845',
				'x-diuit-api-key' => '724b4289d769d4d7df9af5842fa49e5c',
				'Content-Type' => 'application/json'
			},
			:data => {
				"authToken" => @token,
				"deviceId" => 'A76E985-2BE5-43D5-BABD-B4671734139C'
			}
		}
		endpoint2 = 'https://api.diuit.net/1/auth/login'

		session_token = RestClient.post(endpoint2,post_request)

		


	end

	def show 
	end
end
