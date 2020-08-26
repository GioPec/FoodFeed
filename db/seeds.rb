# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

    a = User.create(username: "admin", email: "admin@mail.it", password: "adminadmin", role: "A", first_name: "admin", last_name: "admin")
    a.add_role :admin
    a.add_role :admin, Comment
    a.add_role :admin, User
    a.add_role :admin, Recipe
    a.add_role :mod
    a.add_role :mod, Comment
    a.add_role :mod, User
    a.add_role :mod, Recipe
    a.save

    m = User.create(username: "moderator", email: "moderator@mail.it", password: "moderator", role: "M", first_name: "moderator", last_name: "moderator")
    m.add_role :mod
    m.add_role :mod, Comment
    m.add_role :mod, User
    m.add_role :mod, Recipe
    m.save

    u = User.create(username: "user", email: "user@mail.it", password: "useruser", role: "U", first_name: "user", last_name: "user")
    