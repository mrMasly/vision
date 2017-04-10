import _ from 'lodash'

# получить имя пользователя
_users = {}
getUser = (id) ->
  return _users[id] if _users[id]?
  _users[id] = Mongo.Users.findOne(id)?.profile?.name
  return _users[id]
setInterval (=> _users = {}), 60000

repeated =

# создание задачи
insert = (userId, doc) ->

  # ничего не делаем, если эта задача для себя
  # return null if doc.for is userId

  # если не нужно уведомлять
  return null if doc.notification is no

  # если это делегированная задача
  if doc.parent
    Mongo.Notifications.insert
      title: getUser(userId)
      text: "Новая задача: #{doc.title}"
      sref: name: 'app.task', params: id: doc._id
      for: doc.for
      audio: 'notif.mp3'


update = (userId, doc, fields, mod) ->

  # если не нужно уведомлять
  return null if doc.notification is no

  # обновляем значения doc
  doc = _.clone doc
  doc[key] = val for key, val of mod.$set if mod.$set?

  # ничего не делаем, если эта задача для себя
  # return null if doc.for is userId

  # для делегированных задач
  if doc.parent?

    # если обновилась
    if doc.for isnt userId
      Mongo.Notifications.insert
        title: getUser(userId)
        text: "Обновлена задача: #{doc.title}"
        sref: name: 'app.task', params: id: doc._id
        for: doc.for
        audio: 'notif.mp3'

    # если была выполнена
    else if 'done' in fields and doc.done is yes
      Mongo.Notifications.insert
        title: getUser(userId)
        text: "Выполнена задача: #{doc.title}"
        sref: name: 'app.task', params: id: doc._id
        for: doc.createdBy
        audio: 'notif.mp3'



module.exports =
  insert: insert
  update: update
