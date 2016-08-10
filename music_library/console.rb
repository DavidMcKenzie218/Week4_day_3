require_relative('./models/album')
require_relative('./models/artist')

require('pry-byebug')

artist1 = Artist.new({'name' => 'Five FInger Death Punch'})
# artist1.save()

album1 = Album.new({'name' => 'War is the Anser', 'artist_id' => artist1.id()})
album2 = Album.new({'name' => 'Wrong Side of Hevan, Rightous Side of Hell', 'artist_id' => artist1.id()})

binding.pry
nil