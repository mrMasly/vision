import Fiber from 'fibers'
import _ from 'lodash'

module.exports = (userId, doc, fields, mod) ->
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
  if doc.time
    time = moment(doc.time).format('HH:mm:ss')
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
