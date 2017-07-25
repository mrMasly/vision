import _ from 'lodash'
module.exports = (task) ->

  today = moment().format('YYYY-MM-DD')

  task.repeat.every ?= 1

  # находим первую дату
  date = moment(task.repeat.date.start)

  amount = switch task.repeat.type
    when 'day' then 90
    when 'week' then 180
    when 'month' then 365

  # массив для результата
  days = []

  # массив для дней, чтобы считать "каждые 1/2/3/4/5 дней/недель/месяцев"
  arr = []

  # date - moment
  add = (date) ->
    start = task.repeat.date.start
    start = today if today > start
    toDate = date.format('YYYY-MM-DD')
    if toDate >= start
      if task.repeat.date.end is null or toDate <= task.repeat.date.end
        days.push toDate

  # проверяет подходит ли день
  check = ->
    switch task.repeat?.type
      when 'day'
        day = date.format('YYYY-MM-DD')
        arr.push day unless day in arr
        if (arr.length-1) % task.repeat.every is 0
          add date

      when 'week'
        week = moment(date.format('YYYY-MM-DD')).startOf('week').format('L')
        arr.push week unless week in arr
        if (arr.length-1) % task.repeat.every is 0
          if date.day()-1 in task.repeat.week
            add date
      when 'month'
        month = moment(date.format('YYYY-MM-DD')).startOf('month').format('L')
        arr.push month unless month in arr
        if (arr.length-1) % task.repeat.every is 0
          # если повторение по определенным дням месяца
          if task.repeat.month.type is 'month'
            day = date.date()
            if 'last' in task.repeat.month.monthDays
              if date.format('YYYY-MM-DD') is moment(date.toDate()).endOf('month').format('YYYY-MM-DD')
                add date
            if day in task.repeat.month.monthDays
              add date
          # если повторение по определенным дням недели
          else if task.repeat.month.type is 'week'
            # console.log task.repeat.month.weekDay
            day = _.toNumber date.format('e')
            # проверим что это тот день недели что нужен
            if day in task.repeat.month.weekDay
              if 'first' in task.repeat.month.index
                add date if moment(date.toDate()).subtract(1, 'week').startOf('month').format('L') isnt month
              if 'second' in task.repeat.month.index
                add date if moment(date.toDate()).subtract(2, 'week').startOf('month').format('L') isnt month and moment(date.toDate()).subtract(1, 'week').startOf('month').format('L') is month
              if 'third' in task.repeat.month.index
                add date if moment(date.toDate()).subtract(3, 'week').startOf('month').format('L') isnt month and moment(date.toDate()).subtract(2, 'week').startOf('month').format('L') is month
              if 'fourth' in task.repeat.month.index
                add date if moment(date.toDate()).subtract(4, 'week').startOf('month').format('L') isnt month and moment(date.toDate()).subtract(3, 'week').startOf('month').format('L') is month
              if 'last' in task.repeat.month.index
                add date if moment(date.toDate()).add(1, 'week').startOf('month').format('L') isnt month


  do check
  for i in [0..amount]
    date.add(1, 'day'); do check

  # console.log days

  return days
