
export default (group) ->
  async = Async.runSync (done) ->
    Mongo.Users.Groups.upsert group._id
    , $set:
      name: group.name
      description: group.description
    , (err, res) ->
      do done
  return async.result
