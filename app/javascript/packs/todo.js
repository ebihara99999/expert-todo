import Vue from 'vue/dist/vue.esm'
import taskFileForm from '../components/task_files/new.vue'

new Vue({
    el: '#app',
    components: {
      'task-file-form': taskFileForm,
    },
});