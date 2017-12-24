<template>
    <div>
        <h1>ファイル一覧</h1>
        <h2>
            <router-link :to="{ name: 'newTaskFilePath'}">ファイルの添付</router-link>
        </h2>
        <table>
            <thead>
            <tr>
                <th>ファイル名</th>
                <th>作成日</th>
                <th>更新日</th>
                <th>ダウンロード</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="taskFile in taskFiles">
                <td>{{ taskFile.filename }}</td>
                <td>{{ taskFile.created_at }}</td>
                <td>{{ taskFile.updated_at }}</td>
                <td>
                    <button @click="downloadFile(taskFile.attached_file.url, taskFile.filename)">ダウンロード</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: () => {
      return {
        taskFiles: []
      }
    },
    created() {
      this.fetchTaskFiles();
    },
    methods: {
      fetchTaskFiles() {
        let config = {
          headers: {
            'content-type': 'application/json',
            'Authorization': localStorage.getItem('auth-token')
          }
        };

        axios.get(`/tasks/${this.$route.params.task_id}/task_files`, config).then((response) => {
          this.taskFiles = response.data.task_files;
        }).catch((response) => {
          window.location.href = window.location.origin; //認証失敗の場合
          console.log(response);
        });
      },
      downloadFile: function (url, fileName) {
        const AWS = require('aws-sdk');
        const s3 = new AWS.S3({
          s3ForcePathStyle: true,
          region: 'us-west-2',
          accessKeyId: process.env.AWS_ACCESS_KEY_ID,
          secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
        });

        let params = {
          Bucket: process.env.AWS_S3_BUCKET,
          Key: url.match(/(uploads\/.*)/)[0]
        };


        s3.getObject(params, (err, data) => {
          if (err) {
            console.log(err, err.stack);
          } else {

            let blob = new Blob([data.Body], {type: data.ContentType});

            let a = document.createElement('a');
            a.href = window.URL.createObjectURL(blob);
            a.download = fileName;
            a.click();
          }
        });
        // Todo urlの開放
        //window.URL.revokeObjectURL(urlToRelease);
      }
    },
  }
</script>