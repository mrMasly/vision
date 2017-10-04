import Fiber from 'fibers'
import cron from 'cron'

make = ->
  triggerId = Random.id()
  try
    tasks = Mongo.Tasks.find
      'repeat.toggle': yes
      $or: [
        {'repeate.date.end': $gt: moment().toDate()}
        {'repeate.date.end': null}
      ]
    .fetch()
    for task in tasks
      continue unless task.repeat.date?
      Mongo.Tasks.update task._id, $set:
        __trigger: triggerId
    console.log 'Cron for repeated tasks completed'
  catch error
    console.log 'Cron error: ' + error

Meteor.startup ->
  Fiber ->
    if Meteor.isProduction
      do make
      new cron.CronJob '00 00 * * *', make, null, yes, 'Asia/Vladivostok'
  .run()
