import Vue from 'vue/dist/vue.esm'
import TaskIndex from '../components/tasks/index.vue'
import TaskNew from '../components/tasks/new.vue'
import TaskEdit from '../components/tasks/edit.vue'
import TaskFileIndex from '../components/task_files/index.vue'
import TaskFileNew from '../components/task_files/new.vue'
import VueRouter from 'vue-router';

Vue.use(VueRouter);

const routes = [
  { path: '/tasks', name: 'tasksPath', component: TaskIndex},
  { path: '/tasks/new', name: 'newTaskPath', component: TaskNew},
  { path: '/tasks/:id/edit', name: 'editTaskPath', component: TaskEdit},
  { path: '/tasks/:task_id/task_files/:id', name: 'taskFileShowPath'},
  { path: '/tasks/task_end', name: 'taskEndPath'},
  { path: '/tasks/:task_id/task_files', name: 'taskFilesPath', component: TaskFileIndex},
  { path: '/tasks/:task_id/task_files/new', name: 'newTaskFilePath', component: TaskFileNew},
  { path: '/tasks/:task_id/task_files/:id', name: 'taskFilePath'},
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
