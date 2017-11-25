import Vue from 'vue/dist/vue.esm.js'
import Uploader from '../components/file_uploader.vue'

var app = new Vue({
    el: '#app',
    components: {
      'uploader': Uploader,
    },
});