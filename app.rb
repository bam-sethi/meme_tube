require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'pg'
#look up httparty , useful?

before do 
  @db = PG.connect(dbname: 'memetube', host: 'localhost')
end

after do 
  @db.close
end


get '/'  do
  redirect to '/index'
end

# `index` list all videos in our database.
get '/index'  do
  sql = "select * from memetube"
  @videos = @db.exec(sql)
  erb :index
end

# `new` renders a form , where u can add a new video with all the associated fields (see the `sql` file). 
get '/index/new' do 
  erb :new
end

#`create` a new video and insert it in to the database. 
# Perhaps you can redirect to the newly created video page after?
post '/index' do
  if [:link]
    link = parmas[:link]
  end

  sql = "insert into memetube (title, description) VALUES ('#{params[:link]}', '#{[:description]}')"
  @video = @db.exec(sql)
  binding.pry
  ##the below needs to be specific to whatever the video added is 
  redirect to '/index/:id'
end

# `show` page will display the single video you have clicked on from the id.
get '/index/:id' do 

end
