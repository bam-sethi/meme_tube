require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'pg'
require 'httparty'


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
post '/index' do
  # binding.pry
  if params[:link]
    # binding.pry
    #what should the link look like when we get it 
    link = params[:link]
    url = "https://www.youtube.com/embed/#{link}"
    @video_link = HTTParty.get(url)
    # binding.pry
    sql = "insert into memetube (link, title, description) VALUES ('#{@video_link['link']}', '#{params[:title]}', '#{params[:description]}')"
    @videos = @db.exec(sql)
    
  end
  # Perhaps you can redirect to the newly created video page after?
  ##the below needs to be specific to whatever the video added is 

  redirect to '/index/:id'
end

# `show` page will display the single video you have clicked on from the id.
get '/index/:id' do 
  sql = "select * from memetube where "
  "hi world"
  erb :show
end
