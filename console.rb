require_relative("./models/album.rb")
require_relative("./models/artist.rb")
require("pry")


Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  "name" => "Spice Girls"
})

artist1.save()

artist2 = Artist.new({
  "name" => "Boyzone"
})

artist2.save()

artist3 = Artist.new({
  "name" => "Aqua"
})

artist3.save()

artists = Artist.all()

album1 = Album.new({
  "artist_id" => artist1.id,
  "title" => "Spice World",
  "genre" => "Rock"
  })

album1.save()

album2 = Album.new({
  "artist_id" => artist2.id,
  "title" => "Said and Done",
  "genre" => "Pop"
  })

album2.save()

album3 = Album.new({
  "artist_id" => artist3.id,
  "title" => "Aquarium",
  "genre" => "Pop"
  })

album3.save()

albums = Album.all()

binding.pry
nil
