require("pg")
require_relative("../db/sql_runner.rb")

class Artist

  attr_accessor :name
  attr_reader :id


  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]
  end



  def save()
    sql = "INSERT INTO artists (name)
  VALUES ($1)
  RETURNING id;
  "
  values = [
    @name
  ]
  result = SqlRunner.run(sql, values)
  @id = result[0]["id"].to_i()
  end




  def self.all()
    sql = "SELECT * FROM artists;"
    artist_hashes = SqlRunner.run(sql)

    artist_objects = artist_hashes.map do |artist_hash|
      Artist.new(artist_hash)
    end
    return artist_objects
  end



  def self.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end



  def update()
    sql = "
      UPDATE artists
      SET title = $1
      WHERE id = $2;
      "
    values = [
      @name,
      @id
    ]
    SqlRunner.run(sql, values)
  end



  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    artist_hash = results[0]
    artist = Artist.new(artist_hash)
    return artist
  end

  def albums()

    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    results = SqlRunner.run(sql, [@id])

    albums = results.map do | album_hash |
      Album.new(album_hash)
    end
    return albums
  end



end
