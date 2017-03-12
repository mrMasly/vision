
export removeUser = (userId) ->
  async = Async.runSync (done) ->
    Mongo.Users.remove userId, (err, res) ->
      do done
  return async.result

export removeGroup = (groupId) ->
  async = Async.runSync (done) ->
    Mongo.Users.Groups.remove groupId, (err, res) ->
      do done
  return async.result
