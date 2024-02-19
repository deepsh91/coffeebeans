module ExternalApi
	module Iterable
		module Request
			module Base

				# API key to make request
				def api_key
					ENV['ITERABLE_API_KEY']
				end

				# API url
				def url
					URI::join(base_url, endpoint).to_s
				end

				def headers
					{
						'Content-Type' => 'application/json',
						'Api-Key' => api_key
					}
				end

				def base_url
					ExternalApi::Iterable::Constant::BASE_URL
				end
			end
		end
	end
end
