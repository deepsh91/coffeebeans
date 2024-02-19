module ExternalApi
	module Iterable
		module Request
			class Email
				include Base

				attr_reader :user_email

				def initialize user_email: nil
					@user_email = user_email
				end

				def valid?
					user_email.present?
				end

				def body
					{
					  "campaignId": 0, # TODO: How to obtain campaignId?
					  "recipientEmail": user_email
					}
				end

				def endpoint
					ExternalApi::Iterable::Constant::Endpoint::EMAIL
				end
			end
		end
	end
end
