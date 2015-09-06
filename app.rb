require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'pg'


before do 
  @db = PG.connect(dbname: 'memetube', host: 'localhost')
end

after do 
  @db.close
end

#HOME
get '/'  do
  redirect to '/videos'
end

# INDEX
get '/videos'  do
  sql = "select * from memetube"
  @video = @db.exec(sql)
  erb :index
end

# NEW
get '/videos/new' do 
  erb :new
end

#CREATE
post '/videos' do
  if params[:link]
    @link = params[:link]
    @video_link = ("https://www.youtube.com/embed/#{@link}")
    sql = "INSERT INTO memetube (link, title, description) VALUES ('#{@video_link}', '#{params[:title]}', '#{params[:description]}')"
    @video = @db.exec(sql).first
  end
    redirect to "/videos/#{@video['id']}" 
end

# SHOW
get '/videos/:id' do 
  sql = "select * from memetube where id = #{params[:id]}"

  @video = @db.exec(sql).first
  erb :show
end

#EDIT
get '/videos/:id/edit' do
  sql = "select * from memetube where id = #{params[:id]}"
  @video = @db.exec(sql).first
  erb :edit
end


# UPDATE
post '/videos/:id' do
  sql = "update memetube set link = '#{params[:link]}', title = '#{params[:title]}', description = '#{params[:description]}' where id = #{params[:id]}"
  @db.exec(sql)

  redirect to "/videos/#{params['id']}"
end
#DELETE
post '/videos/:id/delete' do
  sql = "delete from memetube where id = #{params[:id]}"
  @db.exec(sql)
  redirect to '/videos'
end


#################################################

# get '/videos' do
#   sql= "select id from memetube order by random() limit 1" 
#   @id = @db.exec(sql)
#   redirect to "/videos/#{params['@id']}/random"
# end






# get '/videos' do

#   sql= "select id from memetube order by random() limit 1" 
#   @random = @db.exec(sql)
#   redirect to "/videos/:id/random"
#   binding.pry
# end


# get '/videos/:id/random' do
# 'hi'
#  #  sql = "select * from memetube order by random() limit 1"
#  #  @video = @db.exec(sql)
#  # erb :random
# end
