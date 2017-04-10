
# при удалении задачи
module.exports = (userId, doc) ->

  # удаляем все зависимые задачи
  if doc.users?.length
    Mongo.Tasks.remove
      done: no
      parent: doc._id

  if doc.repeat?.toggle
    Mongo.Tasks.remove
      done: no
      repeatBy: doc._id
