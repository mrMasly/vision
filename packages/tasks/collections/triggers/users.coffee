import Fiber from 'fibers'
import _ from 'lodash'

module.exports = (userId, doc, fields, mod) ->
  unless fields?
    unless _.isEmpty doc.users
      insert userId, doc
    else
      doc.for ?= userId
      doc.users = []
  else if 'users' in fields
    update arguments...
  else if doc.users?.length
    updateChildren arguments...
  # else
    # mod.$set.for ?= userId

# обновить все подчиненные задачи
updateChildren = (userId, doc, fields, mod) ->
  $set = _.omit _.clone(mod.$set), 'done'
  Mongo.Tasks.update {parent: doc._id}, {$set: $set}, {multi: yes}


# при создании
insert = (userId, doc) ->
  make userId, doc

# при обновлении
update = (userId, doc, fields, mod) ->
  doc = _.clone doc
  for field, value of mod.$set
    doc[field] = value
  make userId, doc


make = (userId, doc) ->
  console.log moment(doc.date).format 'L'
  remove doc._id # удаляем все подчиненные задачи
  # не создаем задачи если эта задача - повторяющаяся
  return null if doc.repeat?.toggle
  create userId, doc if doc.users.length # создаем задачи

# создаем задачи если это мульти-задача
create = (userId, doc) ->
  _doc = _.omit _.clone(doc), ['_id', 'createdAt', 'createdBy', 'updateAt', 'updateBy', 'repeatBy']
  _doc.parent = doc._id
  # _doc.fromUser = Mongo.Users.findOne(userId)?.profile?.name
  _doc.from = userId
  for user in doc.users
    # console.log user
    _doc.for = user
    _doc.users = []
    Mongo.Tasks.insert _doc

# удаляет все старые задачи
remove = (docId) ->
  fiber = Fiber.current
  Mongo.Tasks.remove
    parent: docId
    # done: no
    # date: $gte: moment().toDate()
  , -> do fiber.run
  do Fiber.yield
