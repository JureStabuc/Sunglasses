require 'rubygems'
require 'sinatra'
require 'forecast_io'


ForecastIO.configure do |configuration|
	configuration.api_key = 'cd3c3e767f7c3b35ce602781e96f3289'
end

get'/' do

	forecast = ForecastIO.forecast(37.8267,-0.083333)

	@sunset  =  forecast.daily.sunsetTime
	@sunrise =  forecast.daily.sunriseTime
	timeu    =  Time.at(forecast.currently.time)
	@time    =  timeu.to_time
	
erb :home

end
