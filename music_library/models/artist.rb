require ('pg')
 
require_relative ('./album')

class Artist

  attr_reader(:id, :name)

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING *;"
    artist = SqlRunner.run(sql).first
    @id = artist['id'].to_i
  end

  def self.albums(name)
    sql = "SELECT * FROM artists INNER JOIN albums ON artists.id = albums.artist_id WHERE artists.name = '#{name}';"
    music_list = SqlRunner.run(sql)
    return music_list.map {|music| Album.new(music)}
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{@id}"
    albums = SqlRunner.run(sql)
    result = albums.map {|album| Album.new(album)}
    return result
  end

  def self.all
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    result = artists.map {|artist| Artist.new(artist)}
    return result
  end

  def self.find (id)
    sql = "SELECT * FROM artists WHERE id = #{id}"
    artists = SqlRunner.run(sql).first
    return Artist.new(artists)
  end


  def self.update(options)
    sql = "UPDATE artists SET
      name = '#{options['name']}' WHERE id = #{options['id']};"
      SqlRunner.run(sql)
  end

  def self.destroy(id)
    sql = "DELETE FROM artists WHERE id = #{id}"
    SqlRunner.run(sql)
  end

end