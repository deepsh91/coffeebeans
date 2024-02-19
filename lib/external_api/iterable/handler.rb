module ExternalApi
	module Iterable
		class Handler
			attr_reader :request, :response
			
			def initialize request:
				@request = request
				raise "Invalid request argument" unless valid?
				@response = nil
			end

			def fetch
				begin
					resp = HTTParty.post(request.url, body: request.body.to_json, headers: request.headers)
					@response = ExternalApi::Iterable::Response.new(resp: resp)
					return response
				rescue => ex
					# TODO
				end
			end

			private

			def valid?
				request_class_valid? && request_valid?
			end

			def request_class_valid?
				request.instance_of?(ExternalApi::Iterable::Request::Event) || request.instance_of?(ExternalApi::Iterable::Request::Email) 
			end

			def request_valid?
				request&.respond_to?('valid?') && request.valid?
			end
		end
	end
end
