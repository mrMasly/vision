Meteor.publish '--users--groups--', ->
  Mongo.Users.find {}, fields: groups: 1