# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@shelter1 = Shelter.create!(name: "Alfredo's Adoption",
                            address: "55555",
                            city: "Denver",
                            state: "CO",
                            zip: "34213",
                            id: "1")
@shelter2 = Shelter.create!(name: "Johnny Bob's 'Doption",
                            address: "1185",
                            city: "Denver",
                            state: "CO",
                            zip: "80205",
                            id: "2")

@pet1 = Pet.create!(name: "Jimbo",
                    approximate_age: "1",
                    sex: "male",
                    image: "jimbo.jpg",
                    adoption_status: "Adoptable",
                    current_location: "Alfredo's Adoption",
                    shelter_id: "1")
@pet2 = Pet.create!(name: "Elmer",
                    approximate_age: "5",
                    sex: "male",
                    image: "elmer.jpg",
                    adoption_status: "Adoptable",
                    current_location: "Alfredo's Adoption",
                    shelter_id: "2")

@review = @shelter1.reviews.create!(title: "Terrible Service",
                                  rating: 1,
                                  content: "We did eight hours just to get my dog!! And when I got him he was covered in chocolate syrup :(",
                                  image: "https://static1.squarespace.com/static/539c4601e4b0baefd4e19bea/5e7cc2fc2df85777bad3e6f0/59bc5a0ae9bfdf77f6f2abe9/1585240864313/?format=1500w")
