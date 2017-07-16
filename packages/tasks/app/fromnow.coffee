import _ from 'lodash'
module.exports = (taskDate, showDate=yes, showTime=yes) ->
  if taskDate is null
    return 'Входящие'
  if taskDate is no
    return 'Когда-нибудь'

  date = moment(taskDate).startOf('day').format('X')
  today = moment().startOf('day').format('X')
  delta = (date - today) / 86400
  if delta is 1
    relation = 'Завтра'
  else if delta is 2
    relation = 'Послезавтра'
  else if delta is -1
    relation = 'Вчера'
  else if delta is -2
    relation = 'Позавчера'
  else if delta is 0
    relation = 'Сегодня'
  else
    date = moment(taskDate).format('YYYY-MM-DD')
    time = moment().format('HH:mm:ss')
    relation = moment(date+' '+time).fromNow()
  
  result = []
  result.push relation
  
  if showDate
    result.push moment(taskDate).format('D MMMM YYYY')
  
  if showTime
    time = moment(taskDate).format('HH:mm:ss')
    if time isnt '00:00:00'
      # if relation is 'Сегодня'
      #   result.push moment(taskDate).fromNow()
      # else
      #   result.push "в "+time[0..4]
      result.push "в "+time[0..4]
  
  return _.upperFirst result.join ', '

    
    