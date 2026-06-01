# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Passenger.destroy_all
Booking.destroy_all
Flight.destroy_all
Airport.destroy_all

sfo = Airport.create!(code: "SFO")
nyc = Airport.create!(code: "NYC")
lax = Airport.create!(code: "LAX")
ord = Airport.create!(code: "ORD")
sea = Airport.create!(code: "SEA")

airports = [sfo, nyc, lax, ord, sea]

20.times do
  departure = airports.sample
  arrival = (airports - [departure]).sample

  Flight.create!(
    departure_airport: departure,
    arrival_airport: arrival,
    start_datetime: rand(1..10).days.from_now.change(hour: [8, 10, 12, 14, 16, 18].sample),
    duration: rand(90..420)
  )
end