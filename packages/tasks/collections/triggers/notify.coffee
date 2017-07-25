import _ from 'lodash'

# получить имя пользователя
_users = {}
getUser = (id) ->
  return _users[id] if _users[id]?
  _users[id] = Mongo.Users.findOne(id)?.profile?.name
  return _users[id]
setInterval (=> _users = {}), 60000

# создание задачи
insert = (userId, doc) ->

  # ничего не делаем, если эта задача для себя
  # return null if doc.for is userId

  # если не нужно уведомлять
  return null if doc.notify is no


  # если это делегированная задача
  if doc.parent
    Mongo.Vision.Notify.insert
      title: getUser(userId)
      text: "Новая задача: #{doc.title}"
      route: query: task: doc._id
      for: doc.for


update = (userId, doc, fields, mod) ->

  # обновляем значения doc
  doc = _.clone doc
  doc[key] = val for key, val of mod.$set if mod.$set?

  # ничего не делаем, если эта задача для себя
  # return null if doc.for is userId

  # для делегированных задач
  if doc.parent?

    # если обновилась
    if doc.for isnt userId and doc.notify isnt no
      Mongo.Vision.Notify.insert
        title: getUser(userId)
        text: "Обновлена задача: #{doc.title}"
        route: query: task: doc._id
        for: doc.for

    # если была выполнена
    else if 'done' in fields and doc.done is yes
      Mongo.Vision.Notify.insert
        title: getUser(userId)
        text: "Выполнена задача: #{doc.title}"
        route: query: task: doc.parent
        for: doc.createdBy

module.exports =
  insert: insert
  update: update
