
Mongo.Vision ?= {}
Mongo.Vision.Notify = new Mongo.Collection 'vision.notify'

Mongo.Vision.Notify.allow
  insert: (userId, doc) -> yes
  update: (userId, doc) -> yes

if Meteor.isServer
  Fiber = require 'fibers'
  Mongo.Vision.Notify.before.insert (userId, doc) ->
    doc._id = Random.id(17)
    doc.viewed ?= no
    doc.alert ?= yes
    setTimeout ->
      Fiber ->
        Mongo.Vision.Notify.update doc._id, $set: alert: no
      .run()
    , 10000
    return yes

Mongo.Vision.Notify.attachBehaviour 'timestampable'
