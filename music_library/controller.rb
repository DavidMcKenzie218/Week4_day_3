require 'sinatra'
require 'sinatra/contrib/all'
require 'pry-byebug'

require_relative './models/album'
require_relative './models/artist'

get('/') do
  erb(:home)
end

#ARTISTS

get('/artists/new') do
  erb(:new_artist)
end

post('/artists') do
  @artist = Artist.new(params)
  @artist.save
  # binding.pry
  erb(:create_artist)
end

get('/artists') do
  @artists = Artist.all()
  erb(:artist_index)
end

get('/artists/:id') do
  @artist = Artist.find(params[:id])
  erb(:artist_show)
end

get('/artists/:id/edit') do
  @artist = Artist.find(params[:id])
  erb(:artist_edit)
end

post('/artists/:id') do
  Artist.update(params)
  redirect(to('/artists'))
end

post('/artists/:id/delete') do
  Artist.destroy(params['id'])
  redirect(to('/artists'))
end

#ALBUMS

get('/albums/new') do
  @artists = Artist.all()
  erb(:new_album)
end

post('/albums') do
  @album = Album.new(params)
  @album.save
  erb(:create_album)
end

get('/albums') do
  @albums = Album.all()
  # binding.pry
  erb(:album_index)
end

get('/albums/:id') do
  @album = Album.find(params[:id])
  erb(:album_show)
end

get('/albums/:id/edit') do
  @artists = Artist.all()
  @album = Album.find(params[:id])
  erb(:album_edit)
end

post('/albums/:id') do
  Album.update(params)
  redirect(to('/albums'))
end

post('/albums/:id/delete') do
  Album.destroy(params['id'])
  redirect(to('/albums'))
end