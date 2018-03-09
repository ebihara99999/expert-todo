<template>
  <div id="file-attachment">
    <div v-if="uploadedImageNames">
      <h3>アップロードされたファイル</h3>
      <ol>
        <li
          v-for="uploadedImageName in uploadedImageNames"
          :key="uploadedImageName"
        >
          <h2>{{ uploadedImageName }}</h2>
        </li>
      </ol>
    </div>

    <div>
      <div v-if="message != ''">{{ message }}</div>
      <h2>Taskにファイルを添付</h2>
      <label for="attachment_file_to_task">ファイルを添付</label>
      <input
        type="file"
        id="attachment_file_to_task"
        @change="onFileChange"
      >
    </div>

    <div v-if="images">
      <ol>
        <li
          v-for="(image, index) in images"
          :key="image.id"
        >
          <h2>{{ image.name }}</h2>
          <img :src="image.thumnail">
          <button @click="images.splice(index, 1)">Remove image</button>
        </li>
      </ol>
    </div>

    <button @click="submitImage(currentPath)">Submit image</button>
  </div>
</template>

<script>
  import axios from 'axios';
  export default {
    data: () => {
      return {
        images: [],
        currentPath: window.location.pathname,
        message: '',
        uploadedImageNames: [],
      };
    },
    methods: {
      onFileChange: function(e) {
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
      submitImage: function(currentPath) {
        let formData = new FormData();
        let path = `/api/v1/${currentPath.replace('/new', '')}`;
        for (let i = 0; i < this.images.length; i++) {
          formData.append('task_file' + i, this.images[i].uploadFile);
        }
        let config = {
          headers: {
            'content-type': 'multipart/form-data',
            'Authorization': localStorage.getItem('auth-token'),
          },
        };
        if (process.env.RAILS_ENV != 'test') {
          // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
          axios.defaults.headers['X-CSRF-TOKEN'] =
            document.getElementsByName('csrf-token')[0].content;
        }
        axios
          .post(path, formData, config)
          .then((response) => {
            for (let image of this.images) {
              this.uploadedImageNames.push(image.name);
            }
            this.images = [];
            console.log(response);
            alert('ファイルを添付しました');
          })
          .catch((error) => {
            console.log(error);
            alert('ファイルを添付できませんでした');
          });
      },
    },
  };
</script>
