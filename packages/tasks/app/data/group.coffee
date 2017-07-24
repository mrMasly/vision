module.exports = () ->

  lists = []

  group = Meteor.Store.state.vision.tasks.group
  user = Meteor.Store.state.vision.tasks.user
  # options = Meteor.Store.state.vision.tasks.options

  if group is 'inbox'
    lists.push name: 'Для себя', index: 2, match:
      date: null, "repeat.toggle": no
      done: no, for: user, users: $size: 0
      parent: $exists: no
    lists.push name: 'Новые', index: 1, match:
      done: no, for: user
      parent: $exists: yes
      viewed: no
    lists.push name: 'От других пользователей', index: 3, match:
      done: no, for: user
      parent: $exists: yes
      viewed: yes


  else if group is 'today'
    lists.push name: 'Сделать прямо сейчас', index: -999, match:
      done: no, for: user, just: yes
    lists.push name: 'Сегодня', index: 1, match:
      date:
        $gte: moment().startOf('day').toDate()
        $lte: moment().endOf('day').toDate()
      done: no, for: user, users: $size: 0
      just: $ne: yes
    lists.push name: 'Просроченные', index: 2, match:
      date: $lt: moment().startOf('day').toDate()
      done: no, for: user, users: $size: 0
      just: $ne: yes
    lists.push name: 'Ожидание', index: 2, match:
      date: $lte: moment().endOf('day').toDate()
      done: no, for: user, users: $not: $size: 0
      just: $ne: yes
    lists.push name: 'Выполненные', index: 999, match:
      doneAt:
        $gte: moment().startOf('day').toDate()
        $lte: moment().endOf('day').toDate()
      done: yes, for: user

  else if group is 'week'
    for i in [1..7]
      date = moment().add(i, 'days')
      name = if i is 1 then 'Завтра' else date.format('D MMMM')
      lists.push name: name, index: i, match:
        date:
          $gte: date.startOf('day').toDate()
          $lte: date.endOf('day').toDate()
        done: no, for: user

  else if group is 'someday'
    lists.push name: 'Когда-нибудь', match:
      date: no

  else if group is 'wait'

    lists.push name: 'Сегодня', index:1, match:
      users: $not: $size: 0
      done: no, for: user
      date:
        $gte: moment().startOf('day').toDate()
        $lte: moment().endOf('day').toDate()

    lists.push name: 'Просроченные', index:1, match:
      users: $not: $size: 0
      done: no, for: user
      date: $lte: moment().subtract(1, 'day').endOf('day').toDate()

    lists.push name: 'Следующая неделя', index:2, match:
      users: $not: $size: 0
      done: no, for: user
      date:
        $gte: moment().add(1, 'day').startOf('day').toDate()
        $lte: moment().add(7, 'days').endOf('day').toDate()

    lists.push name: 'Без даты', index:0, match:
      users: $not: $size: 0
      done: no, for: user
      date: null

    lists.push name: 'Выполненные сегодня', match:
      users: $not: $size: 0
      done: yes, for: user
      doneAt:
        $gte: moment().startOf('day').toDate()
        $lte: moment().endOf('day').toDate()

  else if group is 'repeat'

    lists.push name: 'Повторяющиеся', match:
      'repeat.toggle': yes
      # users: $exists: yes
      for: user
      # doneAt:
      #   $gte: moment().startOf('day').toDate()
      #   $lte: moment().endOf('day').toDate()

  else if group is 'search'
    # pattern = new RegExp query, 'i'
    lists.push name: 'Поиск', index: -999, match:
      done: no, for: user
      $or: [
        {title: $regex: query, $options: 'i'}
        {tags: $regex: query, $options: 'i'}
      ]
  # если не разделять по группам
  # unless 'group' in options
  #   $or = []
  #   for list in lists
  #     $or.push list.match
  #   done = _.find lists, name: 'Выполненные'
  #   lists = []
  #   lists.push name: 'Все', index: 1, match: $or: $or, done: no
  #   lists.push done if done?

  # если выделить отдельно задачи от других пользователей
  # if 'users' in options
  #   $or = []
  #   for list in lists
  #     continue if list.match.done or list.match.just is yes
  #     match = _.clone list.match
  #     match.fromUser = $exists: yes
  #     $or.push match
  #     list.match.fromUser = $exists: no
  #   unless _.isEmpty $or
  #     lists.push name: 'От других пользователей', index: 0, open: yes, match: $or: $or

  # если нужно отдельно выделить важные
  # if 'priority' in options
  #   $or = []
  #   for list in lists
  #     continue if list.match.done or list.match.just is yes
  #     match = _.clone list.match
  #     match.priority = 3
  #     $or.push match
  #     list.match.priority = $ne: 3
  #   unless _.isEmpty $or
  #     lists.push name: 'Важные', index: -1, open: yes, match: $or: $or

  # if options.tags
  #   for list in lists
  #     continue if list.match.done
  #     match = _.clone list.match
  #     match.
  #     $or.push match
  #     list.match.priority = $ne: 3

  list.size = 0 for list in lists
  list.open ?= yes for list in lists

  lists = _.sortBy lists, ['index']

  return lists
