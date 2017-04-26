
export removeUser = (userId) ->
  do Meteor.wrapAsync (done) ->
    Mongo.Users.remove userId, (err, res) ->
      do done

export removeGroup = (groupId) ->
  do Meteor.wrapAsync (done) ->
    Mongo.Users.Groups.remove groupId, (err, res) ->
      do done
