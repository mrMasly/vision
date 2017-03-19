
import { RouterFactory, nativeScrollBehavior } from 'meteor/akryum:vue-router2'

router = new RouterFactory
  mode: 'history'
  scrollBehavior: nativeScrollBehavior

export default router
