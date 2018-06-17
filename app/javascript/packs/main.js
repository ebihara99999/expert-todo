import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
import Vuetify from 'vuetify';
import Vuex from 'vuex';

// Custom Components
import TaskIndex from '../components/tasks/index.vue';
import TaskNew from '../components/tasks/new.vue';
import TaskEdit from '../components/tasks/edit.vue';
import TaskFileIndex from '../components/task_files/index.vue';
import TaskFileNew from '../components/task_files/new.vue';
import SessionNew from '../components/sessions/new.vue';
import UserNew from '../components/registrations/new.vue';
import Header from '../components/shared/header.vue';


Vue.use(VueRouter);
Vue.use(Vuetify);
Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    isLogin: false,
  },
  mutations: {
    login(state) {
      state.isLogin = true;
    },
    logout(state) {
      state.isLogin = false;
    },
  },
  getters: {
    isLogin(state) {
      return state.isLogin;
    },
  },
});

const routes = [
  {path: '/', name: 'rootPath'},
  {path: '/tasks', name: 'tasksPath', component: TaskIndex},
  {path: '/tasks/new', name: 'newTaskPath', component: TaskNew},
  {path: '/tasks/:id/edit', name: 'editTaskPath', component: TaskEdit},
  {path: '/tasks/:taskId/task_files/:id', name: 'taskFileShowPath'},
  {path: '/tasks/task_end', name: 'taskEndPath'},
  {path: '/tasks/:taskId/task_files', name: 'taskFilesPath', component: TaskFileIndex},
  {path: '/tasks/:taskId/task_files/new', name: 'newTaskFilePath', component: TaskFileNew},
  {path: '/tasks/:taskId/task_files/:id', name: 'taskFilePath'},
  {path: '/sessions/new', name: 'newSessionPath', component: SessionNew, props: true},
  {path: '/registrations/new', name: 'newUserPath', component: UserNew},
];

const router = new VueRouter({
  mode: 'history',
  routes,
});

new Vue({
  el: '#app',
  store,
  router,
  components: {
    'navbar': Header,
  },
});
