require 'rubygems'
require 'sinatra'
require 'forecast_io'


ForecastIO.configure do |configuration|
	configuration.api_key = 'cd3c3e767f7c3b35ce602781e96f3289'
end

ForecastIO.configure do |configuration|
  configuration.default_params = {units: 'si'}
end


get'/' do



forecast = ForecastIO.forecast(41.844,-73.5942)
@forecast1 = forecast.currently.summary


@sunset =  forecast.daily.sunsetTime
@sunrise = forecast.daily.sunriseTime
@time1 =    Time.at(forecast.currently.time)
@time = @time1.to_datetime

	

	
erb :home

end
