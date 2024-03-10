# Iterable Integration

Application to generate events and send emails to users using Iterable [API](https://api.iterable.com/api/docs).

### Application Setup
1. You need to install [Docker](https://www.docker.com/products/docker-desktop/) to run this app.
2. Clone repo
3. In project dir, run `docker-compose up`. If you are running for the first time, it will download required docker images first and then spin containers.
4. Visit `localhost:3000` to use the app

### Docker Services
This app utilises docker compose to run supporting services
- `postgres` for backend database
- `sidekiq` for background processing
- `redis` for sidekiq job store

### Gem Dependencies
- `devise` for user signup and login
- `sidekiq` for background processing
- `httparty` for API calls
- `webmock` for API mocking
- `rspec` for testing

### Description
1. User needs to sigup/login to be able to use the app
2. Once logged in, there will be 2 button displayed
3. User can generate two type of Iterable Events (A and B) by clicking respective buttons. It utilises session store to maintain a simple counter of number of events created, since we are not persisting events in local database
4. For each event generated, a background job `EventCreationJob` is enqueued. This job gets processed by Sidekiq workers.
	a. Each worker makes an API call to Iterable's [Event API](https://api.iterable.com/api/docs#events_track) and create a new event.
	b. If Event B was generated, it further enqueues another job `EmailDeliveryJob` to send email notification using Iterable's [Email API](https://api.iterable.com/api/docs#email_target).
5. All API requests to Iterable are mocked using Webmock. See [this](lib/external_api/iterable/mock.rb).

### Testing Application
- `RAILS_ENV=test bundle exec rspec`