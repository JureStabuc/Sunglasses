require 'rubygems'
require 'sinatra'
require 'forecast_io'
require 'geocoder'


Geocoder.configure(:timeout => 60)

ForecastIO.configure do |configuration|
	configuration.api_key = 'cd3c3e767f7c3b35ce602781e96f3289'
end

ForecastIO.configure do |configuration|
  configuration.default_params = {units: 'si'}
end


get'/' do

	result = request.location
	lat = result.latitude
	long = result.longitude

	forecast = ForecastIO.forecast(lat, long)
	@forecast = forecast.currently.summary
	@clouds = forecast.currently.cloudCover

	sunset = forecast.currently.sunsetTime
	sunrise = forecast.currently.sunriseTime
	time = forecast.currently.time
	@daytime = time >= sunrise && time <= sunset

	@sunglasses
	             if 
	             	(@clouds >= 0 && @clouds <= 0.4 && @daytime) 
	             	@clouds = "Pack a pair of sunglasses"
                 elsif
                 	(@clouds >= 0.4 && @clouds <= 1 && @daytime)
                    @clouds = "Maybe Tomorrow"
                 else
                 	"Only douchebags wear sunglasses at night!"
                end
	
erb :home

end
