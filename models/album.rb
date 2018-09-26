require("pg")
require_relative("../db/sql_runner.rb")

class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre


  def initialize(options)
    @id = options["artist_id"].to_i()
    @artist_id = options["artist_id"].to_i()
    @title = options["title"]
    @genre = options["genre"]
  end




  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    results = SqlRunner.run(sql, [@artist_id])
    artist_hash = results[0]
    artist = Artist.new(artist_hash)
    return artist
  end




  def save()
    sql = "INSERT INTO albums (artist_id, title, genre)
    VALUES ($1, $2, $3)
    RETURNING id;
    "
    values = [
      @artist_id,
      @title,
      @genre
    ]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i()
  end





  def self.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end





  def self.all()
    sql = "SELECT * FROM albums;"
    album_hashes = SqlRunner.run(sql)

    album_objects = album_hashes.map do |album_hash|
      Album.new(album_hash)
    end
  return album_objects
  end



  def update()
    sql = "
      UPDATE albums
      SET (
        title,
        genre
      ) = ( $1, $2)
      WHERE id = $3;
    "
    values = [
      @name,
      @title,
      @id
    ]
    SqlRunner.run(sql, values)
  end





end
