class GraphController < ApplicationController
  def index
    api_response = RestClient.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=1min&apikey=REQPDVQUZP4HXB13')
    alpha_datum=JSON.parse(api_response)["Time Series (1min)"]
    @alpha_info=JSON.parse(api_response)["Meta Data"]
    @open_alpha_data={}
    @high_alpha_data={}
    @low_alpha_data={}
    @close_alpha_data={}
    alpha_datum.each_with_index do |alpha_data, index|
      @open_alpha_data.merge! index.minute.ago.in_time_zone("Eastern Time (US & Canada)") => alpha_data.second["1. open"]
      @high_alpha_data.merge! index.minute.ago.in_time_zone("Eastern Time (US & Canada)") => alpha_data.second["2. high"]
      @low_alpha_data.merge! index.minute.ago.in_time_zone("Eastern Time (US & Canada)") => alpha_data.second["3. low"]
      @close_alpha_data.merge! index.minute.ago.in_time_zone("Eastern Time (US & Canada)") => alpha_data.second["4. close"]
    end
    @minimum_y = [@open_alpha_data.values.min , @close_alpha_data.values.min, @high_alpha_data.values.min, @low_alpha_data.values.min ].min.to_f  - 0.0005
    @maximum_y = [@open_alpha_data.values.max , @close_alpha_data.values.max, @high_alpha_data.values.max, @low_alpha_data.values.max ].max.to_f + 0.0005
  end
end
