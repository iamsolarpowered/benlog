require 'json'

class Chart
  
  def self.requests_by_uri_and_date(requests, dates)
    series = []
    requests.group_by(&:uri).each do |uri, requests_for_uri|
      data = []
      requests_by_date = requests_for_uri.group_by {|r| r.created_at.to_date }
      dates.each do |date|
        data << (requests_by_date[date].count rescue 0)
      end
      series << {
        'name' => uri, 
        'pointInterval' => 60*60*24 * 1000, # 1 day in miliseconds 
        'pointStart' => Time.parse(dates.first.to_s).to_i * 1000, # yeah, annoying
        'data' => data
      }
    end
    series.to_json
  end
  
end
