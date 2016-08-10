require ('pg')
require_relative ('../db/sql_runner')
require_relative ('./artist')

class Album

  attr_reader(:id, :artist_id, :name)

  def initialize(options)
    @id = options['id'].to_i
    @artist_id = options['artist_id'].to_i
    @name = options['name']
  end

  def save
    sql = "INSERT INTO albums (name, artist_id) VALUES ('#{@name}', #{@artist_id}) RETURNING *;"
    album = SqlRunner.run(sql).first
    @id = album['id'].to_i
  end

  def self.artist(album)
    sql = "SELECT artists.name, artists.id FROM artists INNER JOIN albums ON artists.id = albums.artist_id WHERE albums.name = '#{album}';"   
    artist_list = SqlRunner.run(sql)
    return artist_list.map {|album_of_artist| Artist.new(album_of_artist)}
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = #{@artist_id}"
    artist = SqlRunner.run(sql).first
    Artist.new(artist)
  end

  def self.all
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    result = albums.map {|album| Album.new(album)}
    return result
  end

  def self.find (id)
    sql = "SELECT * FROM albums WHERE id = #{id}"
    album = SqlRunner.run(sql).first
    return Album.new(album)
  end


  def self.update(options)
    sql = "UPDATE albums SET
      name = '#{options['name']}' WHERE id = #{options['id']};"
      SqlRunner.run(sql)
  end

  def self.destroy(id)
    sql = "DELETE FROM albums WHERE id = #{id}"
    SqlRunner.run(sql)
  end

end