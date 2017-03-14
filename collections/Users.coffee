Mongo.Vision ?= {}

Mongo.Users = Meteor.users

Mongo.Users.allow
  update: (userId, doc, fields, mod) ->
    return yes if fields[0] is 'photo'

Mongo.Users.attachBehaviour 'files',
  field: 'photo'
  dir: Meteor.root+'/../files/users'
  url: '/files/users'
  stores:
    xs: [50, 50]
    sm: [100, 100]
    md: [250, 250]

Mongo.Users.Groups = new Mongo.Collection 'users_groups'
