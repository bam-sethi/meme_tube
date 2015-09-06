require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'pg'
# require 'httparty'


before do 
  @db = PG.connect(dbname: 'memetube', host: 'localhost')
end

after do 
  @db.close
end


get '/'  do
  redirect to '/videos'
end

# `index` list all videos in our database.
get '/videos'  do
  sql = "select * from memetube"
  @video = @db.exec(sql)
  erb :index
end

# `new` renders a form , where u can add a new video with all the associated fields (see the `sql` file). 
get '/videos/new' do 
  erb :new
end

#`create` a new video and insert it in to the database. 
post '/videos' do
  # binding.pry
  if params[:link]
    # binding.pry
    #what should the link look like when we get it 
    @link = params[:link]
    # @url = "https://www.youtube.com/embed/#{@link}"
    # @video_link = HTTParty.get(url)
    @video_link = ("https://www.youtube.com/embed/#{@link}")
    sql = "INSERT INTO memetube (link, title, description) VALUES ('#{@video_link}', '#{params[:title]}', '#{params[:description]}')"
    @video = @db.exec(sql).first
  # Perhaps you can redirect to the newly created video page after?
  redirect to "/videos/#{@video['id']}" 
  end
end

# `show` page will display the single video you have clicked on from the id.
get '/videos/:id' do 
  sql = "select * from memetube where id = #{params[:id]}"

  # sql = "select * from memetube order by id desc limit 1"
  @video = @db.exec(sql).first
  erb :show
end

# The `edit` page will render a form with all the inputs pre-filled with data about that video so you can edit the fields. 
get '/videos/:id/edit' do
  sql = "select * from memetube where id = #{params[:id]}"
  @video = @db.exec(sql).first
  erb :edit
end


# When you submit the form, the video gets `updated`.
post '/videos/:id' do
  sql = "update memetube set link = '#{params[:link]}', title = '#{params[:title]}', description = '#{params[:description]}' where id = #{params[:id]}"
  @db.exec(sql)

  redirect to "/videos/#{params['id']}"
end
#delete
post '/videos/:id/delete' do
  sql = "delete from memetube where id = #{params[:id]}"
  @db.exec(sql)
  redirect to '/videos'
end


#################################################








get '/videos' do
  sql= "select id from memetube order by random() limit 1" 
  @random = @db.exec(sql)

  redirect to "/videos/random/#{@random}"
end


get '/videos/random/:id' do
  'hi'
 #  sql = "select * from memetube order by random() limit 1"
 #  @video = @db.exec(sql)
 # erb :random
end
