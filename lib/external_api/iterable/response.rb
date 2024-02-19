module ExternalApi
	module Iterable
		class Response
			attr_reader :resp

			def initialize resp:
				@resp = resp
			end

			#####################

			def response_body
				payload
			end

			def response_code
				resp.code
			end

			def response_message
				resp.message
			end

			def response_headers
				resp.headers
			end

			#####################

			def msg
				payload&.dig(:msg)
			end

			def code
				payload&.dig(:code)
			end

			def params
				payload&.dig(:params)
			end

			private

			def payload
				JSON.parse(resp.body).deep_symbolize_keys
			end
		end
	end
end
