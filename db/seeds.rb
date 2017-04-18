# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cat1 = Cat.create!(name: "Cat", color: "grey", birth_date: Date.today, sex: "M", description: "cat-like")
cat1 = Cat.create!(name: "Tony", color: "orange", birth_date: Date.today.prev_day, sex: "M", description: "He's grrrrreat!")
cat1 = Cat.create!(name: "Garfield", color: "orange", birth_date: Date.today, sex: "M", description: "Likes lasagna.")
