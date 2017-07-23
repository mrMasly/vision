import Fiber from 'fibers'
import _ from 'lodash'

module.exports = (userId, doc, fields, mod) ->
  
  data = _.assign doc, mod?.$set
  # если это не повторяющаяся задача
  return unless data.repeat.toggle
  
  # если ничего не меняется
  # return if _.isEmpty _.get mod, '$set'

  # если задача была повторяющаяся, а теперь - нет
  if doc.repeat.toggle and _.get(mod, '$set.repeat.toggle') is no
    remove doc._id
    return

  # console.log doc
  # console.log mod
  unless fields?
    if doc.repeat?.toggle
      insert userId, doc
  else if mod.$set?.repeat?.toggle or doc.repeat?.toggle
    update userId, doc, fields, mod

# при создании
insert = (userId, doc) ->
  make userId, doc

# при изменении
update = (userId, doc, fields, mod) ->
  doc = _.clone doc
  for field, value of mod.$set
    doc[field] = value
  make userId, doc

make = (userId, doc) ->
  # удаляем все подчиненные задачи
  remove doc._id
  try
    dates = require('./repeat-dates') doc
  catch error
    console.log error


  # создаем подчиненные задачи
  x = 0
  for date in dates
    x++
    doc.notification = x is 1
    create userId, doc, date


# создаем подчиненные задачи
create = (userId, doc, date) ->
  fiber = Fiber.current
  # console.log 'create'
  _doc = _.omit _.clone(doc), ['_id', 'createdAt', 'createdBy', 'updateAt', 'updateBy', 'repeat']
  _doc.repeatBy = doc._id
  _doc.repeat = toggle: no
  if doc.repeat.date.time
    time = moment(doc.repeat.date.time, 'HH:mm').format('HH:mm:ss')
    _doc.time = yes
  else
    time = '00:00:00'
  _doc.date = moment(date+' '+time).toDate()
  # console.log _doc
  Mongo.Tasks.insert _doc, (err, res) -> do fiber.run
  do Fiber.yield



# удалить все подчиненные задачи
remove = (docId) ->
  fiber = Fiber.current
  Mongo.Tasks.remove
    repeatBy: docId
    done: no
    date: $gte: moment().startOf('day').toDate()
  , (err, res) -> do fiber.run
  do Fiber.yield
