import _ from 'lodash'
# при выполнении задачи сохраняем нужные значание/ отправляем уведомления
module.exports = (userId, doc, fields, mod, options) ->
  # если поле 'done' не изменяется - ничего не делаем
  return null unless 'done' in fields
  if mod.$set.done
    mod.$set.doneBy = userId
    mod.$set.doneAt = moment().toDate()
  else
    mod.$set.doneBy = null
    mod.$set.doneAt = null


  # завершение родительской задачи
  if doc.parent
    doc.notification = yes
    if mod.$set.done
      # находим все дочерние задачи
      noDone = Mongo.Tasks.find
        parent: doc.parent
        _id: $ne: doc._id
        done: no
      .count()
      # если не осталось невыполненных задача -
      if noDone is 0
        Mongo.Tasks.update {_id: doc.parent, done: no}, $set: done: yes
    else
      Mongo.Tasks.update {_id: doc.parent, done: yes}, $set: done: no
