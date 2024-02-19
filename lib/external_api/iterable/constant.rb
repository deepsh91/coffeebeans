module ExternalApi
	module Iterable
		module Constant
			BASE_URL = "https://api.iterable.com".freeze

			module Endpoint
				EVENT = "/api/events/track".freeze
				EMAIL = "/api/email/target".freeze
			end
		end
	end
end
