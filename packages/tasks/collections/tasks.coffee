Mongo.Tasks = new Mongo.Collection 'vision.tasks'

Mongo.Tasks.attachBehaviour 'timestampable'

Mongo.Tasks.allow
  insert: (userId, doc) ->
    return yes
  update: (userId, doc) ->
    userId is doc.createdBy or userId is doc.for
  remove: (userId, doc) ->
    userId is doc.createdBy

Mongo.Tasks.before.insert (userId, doc) ->
  doc.chat ?= []
  doc.priority ?= 0
  doc.done = no
  if Meteor.isServer
    try
      require('./triggers/users.coffee') arguments...
      require('./triggers/repeat.coffee') arguments...
      require('./triggers/for.coffee') arguments...
      # require('./triggers/notifications.coffee').insert arguments...
    catch error
      console.error error


  return


Mongo.Tasks.before.update (userId, doc, fields, mod, options) ->
  if Meteor.isServer
    try
      require('./triggers/subs.coffee') arguments...
      require('./triggers/done.coffee') arguments...
      require('./triggers/users.coffee') arguments...
      require('./triggers/repeat.coffee') arguments...
      require('./triggers/for.coffee') arguments...
      # require('./triggers/notifications.coffee').update arguments...
    catch error
      console.error error


  return

Mongo.Tasks.before.remove (userId, doc) ->
  if Meteor.isServer
    require('./triggers/remove.coffee') arguments...
