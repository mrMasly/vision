
import {Router, nativeScrollBehavior} from 'meteor/akryum:vue-router2';

router = new Router
  mode: 'history'
  scrollBehavior: nativeScrollBehavior

export default router
