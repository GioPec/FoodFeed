# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

    a = User.create(username: "admin", email: "a@a.a", password: "aaaaaaaa", role: "A", first_name: "admin", last_name: "admin")
    a.add_role :admin
    a.add_role :admin, Comment
    a.add_role :admin, User
    a.add_role :admin, Recipe
    a.add_role :mod
    a.add_role :mod, Comment
    a.add_role :mod, User
    a.add_role :mod, Recipe
    a.save