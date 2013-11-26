require 'rubygems'
require 'sinatra'
require 'forecast_io'


ForecastIO.configure do |configuration|
	configuration.api_key = 'cd3c3e767f7c3b35ce602781e96f3289'
end

get'/' do

	forecast = ForecastIO.forecast(37.8267,-0.083333)
	clouds = forecast.currently.cloudCover

	sunset  =  Time.at(forecast.daily.data[0].sunsetTime).to_time
	sunrise =  Time.at(forecast.daily.data[0].sunriseTime).to_time
	time    =  Time.at(forecast.currently.time).to_time
	daytime = time >= sunrise && time <= sunset

	@sunglasses =
	             if 
	             	(clouds >= 0 && clouds <= 0.4 && daytime) 
	             	@sunglasses = "Pack a pair of sunglasses"
                 elsif
                 	(clouds >= 0.4 && clouds <= 1 && daytime)
                    @sunglasses = "Maybe Tomorrow"
                 else
                 	"Only douchebags wear sunglasses at night!"
                end
	
	
erb :home

end
