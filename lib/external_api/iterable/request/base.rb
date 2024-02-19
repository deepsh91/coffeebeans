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
					# TODO: Add api key to header
				end

				def base_url
					ExternalApi::Iterable::Constant::BASE_URL
				end
			end
		end
	end
end


### event

# request
# /api/events/track
# {
#   "email": "string",
#   "userId": "string",
#   "eventName": "string",
#   "id": "string",
#   "createdAt": 0,
#   "dataFields": {},
#   "campaignId": 0,
#   "templateId": 0,
#   "createNewFields": true
# }

# response body, code, headers
# {
#   "msg": "string",
#   "code": "Success",
#   "params": {}
# }

#### email

# request
# /api/email/target
# {
#   "campaignId": 0,
#   "recipientEmail": "string",
#   "recipientUserId": "string",
#   "dataFields": {},
#   "sendAt": "string",
#   "allowRepeatMarketingSends": true,
#   "metadata": {}
# }

# response body, code, headers
# {
#   "msg": "string",
#   "code": "Success",
#   "params": {}
# }
