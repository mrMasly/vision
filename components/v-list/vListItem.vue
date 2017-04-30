<script lang="coffee">
import vListItemButton from './vListItemButton.vue';
import vListItemLink from './vListItemLink.vue';
import vListItemRouter from './vListItemRouter.vue';
import vListItemExpand from './vListItemExpand.vue';
import vListItemDefault from './vListItemDefault.vue';

component =
  name: 'v-list-item'
  functional: true
  props:
    href: String
    disabled: Boolean
  render: (createElement, _ref) ->
    children = _ref.children
    data = _ref.data
    props = _ref.props

    getItemComponent = ->
      nativeOn = data.nativeOn
      interactionEvents = [
        'contextmenu'
        'dblclick'
        'dragend'
        'mousedown'
        'touchstart'
        'click'
      ]
      childrenCount = children.length
      if props.href
        return vListItemLink
      if nativeOn
        counter = interactionEvents.length
        while counter--
          if nativeOn[interactionEvents[counter]]
            return vListItemButton
      while childrenCount--
        options = children[childrenCount].componentOptions
        if options
          if options.tag == 'v-list-expand'
            _ret = do ->
              expandComponent = children[childrenCount]
              data.scopedSlots = expand: ->
                expandComponent
              children.splice childrenCount, 1
              { v: vListItemExpand }
            if (if typeof _ret == 'undefined' then 'undefined' else _typeof(_ret)) == 'object'
              return _ret.v
          else if options.tag == 'router-link'
            children[childrenCount].data.staticClass = 'v-list-item-container v-button'
            return vListItemRouter
      vListItemDefault

    _data = props: props
    _data[key] = val for key, val of data


    createElement getItemComponent(), _data, children

return component
</script>
