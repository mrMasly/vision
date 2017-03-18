import saveUser from './save-user.coffee'
import removeUserPhoto from './remove-user-photo.coffee'
import saveGroup from './save-group.coffee'
import {removeUser, removeGroup} from './remove.coffee'

Meteor.publish module, 'users', ->
  Mongo.Users.find()

Meteor.publish module, 'user', (id) ->
  Mongo.Users.find(id)


Meteor.publish module, 'groups', () ->
  Mongo.Users.Groups.find()

Meteor.methods module,
  saveUser: saveUser
  saveGroup: saveGroup
  removeUserPhoto: removeUserPhoto
  removeUser: removeUser
  removeGroup: removeGroup
