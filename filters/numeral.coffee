import Vue from 'vue'
import numeral from 'numeral'

Vue.filter 'numeral', (text, format='0,0') ->
  numeral(text).format format
