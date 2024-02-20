module ExternalApi
	module Iterable
		class Handler
			include Mock

			attr_reader :request, :response
			
			def initialize request:
				@request = request
				raise "Invalid request argument" unless valid?
				@response = nil
			end

			def submit!
				begin
					# Enable API mock
					enable_api_mock!

					# mock request
					mock_post_request(request)

					resp = HTTParty.post(request.url, body: request.body.to_json, headers: request.headers)
					@response = ExternalApi::Iterable::Response.new(resp: resp)
				rescue => ex
					puts ex.to_s
				ensure
					# Disable API mock
					disable_api_mock!
					return response
				end
			end

			private

			# Ensure Handler class works only with Iterable::Request type requests
			def valid?
				request_registered? && request_valid?
			end

			def request_registered?
				request.instance_of?(ExternalApi::Iterable::Request::Event) || request.instance_of?(ExternalApi::Iterable::Request::Email) 
			end

			def request_valid?
				request&.respond_to?('valid?') && request.valid?
			end
		end
	end
end
