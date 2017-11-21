<template>
    <div id="file-attachment">
        <div>
            <h2>Taskにファイルを添付</h2>
            <label for="attachment_file_to_task">ファイルを添付</label>
            <input type="file" id="attachment_file_to_task" @change="onFileChange">
        </div>
        <div v-if="images">
            <ol>
                <li v-for="(image, index) in images">
                    <h2>{{image.name}}</h2>
                    <img :src="image.thumnail"/>
                    <button @click="images.splice(index, 1)">Remove image</button>
                </li>
            </ol>
        </div>

        <button id="hogehoge" @click="submitImage(path)">Submit image</button>
    </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: () => {
      return {
        images: [],
        path: window.location.pathname,
      }
    },
    methods: {
      onFileChange: function (e) {
        let files = e.target.files || e.dataTransfer.files;
        this.createImage(files[0]);
      },
      createImage(file) {
        let reader = new FileReader();
        let vm = this;
        let obj = {};
        reader.onload = (e) => {
          obj.thumnail = e.target.result;
          obj.uploadFile = file;
          obj.name = file.name;
          vm.images.push(obj);
        };
        reader.readAsDataURL(file);
      },
      submitImage: function (path) {
        console.log(path)
        let formData = new FormData();
        for (let i = 0; i < this.images.length; i++) {
          formData.append('task_file' + i, this.images[i].uploadFile);
          //hogehoge[`task_file${i}`] = this.images[i].uploadFile
        }
        let config = {
          headers: {
            'content-type': 'multipart/form-data'
          }
        };

        if (process.env.RAILS_ENV != "test") {
          // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
          axios.defaults.headers['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].content;
        }

        axios
          .post(path, formData, config)
          .then((response) => {
            console.log(response);
          })
          .catch( (error) => {
            console.log(error);
          })
      }
    }
  }

</script>