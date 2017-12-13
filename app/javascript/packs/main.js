import Vue from 'vue/dist/vue.esm'
import Uploader from '../components/file_uploader.vue'
import TaskIndex from '../components/tasks/index.vue'
import TaskNew from '../components/tasks/new.vue'
import TaskEdit from '../components/tasks/edit.vue'
import VueRouter from 'vue-router';

Vue.use(VueRouter);

const routes = [
  { path: '/tasks', name: 'tasksPath', component: TaskIndex},
  { path: '/tasks/new', name: 'newTaskPath', component: TaskNew},
  { path: '/tasks/:id/edit', name: 'editTaskPath', component: TaskEdit},
  { path: '/tasks/:task_id/task_files', name: 'taskFilesPath'},
  { path: '/tasks/:task_id/task_files/:id', name: 'taskFileShowPath'},
  { path: '/tasks/:task_id/task_files/new', name: 'newTaskFilePath'},
  { path: '/tasks/task_end', name: 'taskEndPath'},
];

const router = new VueRouter({
  mode: 'history',
  routes
});

new Vue({
  el: '#app',
  router,
  components: {}
});
