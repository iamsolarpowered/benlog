class Request

  include DataMapper::Resource
  property :id, Serial
  property :uri, String
  property :referer, String
  property :agent, String
  property :ip, String
  property :created_at, DateTime

  def self.create_from_env(env)
    create({
      :uri      => env['REQUEST_URI'],
      :referer  => env['HTTP_REFERER'],
      :agent    => env['HTTP_USER_AGENT'],
      :ip       => env['REMOTE_ADDR']
    })
  end

end

