require 'webmock'

module ExternalApi
	module Iterable
		module Mock
			include WebMock::API

			def enable_api_mock!
				WebMock.enable!
			end

			def disable_api_mock!
				WebMock.disable!
			end

			def mock_post_request request
				stub_request(:post, request.url)
					.with(body: request.body.to_json, headers: request.headers)
					.to_return(status: response_success.dig(:status), body: response_success.dig(:body).to_json, headers: response_success.dig(:headers))
			end

			private

			# From Iterable API documentation
			# Refer: https://api.iterable.com/api/docs for more info

			def response_success
				{
					body: response_success_body,
					status: 200,
					headers: {}
				}
			end

			def response_bad_api_key
				{
					body: response_bad_api_key_body,
					status: 401,
					headers: {}
				}
			end

			def response_invalid_params
				{
					body: response_invalid_params_body,
					status: 400,
					headers: {}
				}
			end

			def response_success_body
				{
				  "msg": "request processed",
				  "code": "Success",
				  "params": {}
				}
			end

			def response_bad_api_key_body
				{
				  "msg": "Invalid API key",
				  "code": "BadApiKey",
				  "params": {}
				}
			end

			def response_invalid_params_body
				{
				  "msg": "Invalid parameters",
				  "code": "BadParams",
				  "params": {}
				}
			end
		end
	end
end
