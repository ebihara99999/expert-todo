import Vue from 'vue/dist/vue.esm'
import Uploader from '../components/file_uploader.vue'
import TaskIndex from '../components/tasks/index.vue'
import VueRouter from 'vue-router';

Vue.use(VueRouter);

const routes = [
  { path: '/tasks', component: TaskIndex},
  { path: '/tasks/new', component: Uploader},
];

const router = new VueRouter({
  routes
});

new Vue({
  el: '#app',
  router,
  render: function(createElement) {
    return createElement(App);
  }
});
