

export default (userId) ->
  do Meteor.wrapAsync (done) ->
    Mongo.Avatars.remove {user: userId}, (err, res) ->
      do done
