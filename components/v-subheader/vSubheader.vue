<template lang="jade">
li.v-subheader(:class='[themeClass]', v-if="$parent.$options._componentTag === 'v-list'")
  slot
.v-subheader(:class='[themeClass]', v-else='')
  slot
</template>

<script lang="coffee">

import theme from '../../theme/mixin.js'

component =
  name: 'v-subheader'
  mixins: [theme]
return component
</script>
