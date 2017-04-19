import Vue from 'vue'
import moment from 'moment'


Vue.filter 'moment', (text, format='D MMM YYYY', fromFormat) ->
  if fromFormat?
    date = moment text, fromFormat
  else
    date = moment text
  return date.format format
