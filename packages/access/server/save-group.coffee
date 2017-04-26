
export default (group) ->
  do Meteor.wrapAsync (done) ->
    Mongo.Users.Groups.upsert group._id, $set:
      name: group.name
      description: group.description
    , (err, res) -> do done
