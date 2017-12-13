import Vue from 'vue/dist/vue.esm'
import Uploader from '../components/file_uploader.vue'

new Vue({
    el: '#app',
    components: {
      'uploader': Uploader,
    },
});