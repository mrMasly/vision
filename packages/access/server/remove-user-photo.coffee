

export default (userId) ->
  async = Async.runSync (done) ->
    Mongo.Avatars.remove {user: userId}, (err, res) ->
      do done
  return async.result
