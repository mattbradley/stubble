require 'rubygems'
require 'sinatra'
require 'slim'
require 'mongo'

STUB_LENGTH = 4

# look for the stub; yield to the block if it is found
# or redirect to the root otherwise
def find_stub(stub)
  db = Mongo::Connection.new.db('stubble')['stubs']
  info = db.find_one('stub' => stub)

  redirect '/' if info.nil?

  yield info['url']
end

# find the stub and show where it redirects to
get %r{/([A-Za-z0-9]{4,})/view} do |stub|
  find_stub stub do |url|
    @stub = stub
    @url = url
    slim :view
  end
end

# find the stub and redirect to its url
get %r{/([A-Za-z0-9]{4,})} do |stub|
  find_stub stub do |url|
    redirect url
  end
end

# create a new stub that points to a url
post '/new' do
  @url = params[:url]
  @until = params[:until]

  # generate a random alphanumeric string
  alpha = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
  @stub = (0...STUB_LENGTH).map { alpha[rand(alpha.length)] }.join

  # prefix the url with the 'http://' protocol
  # if a protocol doesn't already exist
  unless /^\w+:\/\// =~ @url
    @url = 'http://' + @url
  end

  db = Mongo::Connection.new.db('stubble')['stubs']
  db.insert( {
    'url' => @url,
    'stub' => @stub,
    'created' => Time.now.utc,
  })

  redirect "/#{@stub}/view"
end

# root
get '/' do
  slim :index
end
