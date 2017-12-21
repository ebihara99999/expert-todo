<template>
    <div>
        <h1>新規作成</h1>
        <form class="new_task" id="new_task" accept-charset="UTF-8" method="post" action="/tasks">
            <label for="task_task_name">タスク名</label>
            <input v-model="task.name" type="text" name="task[task_name]" id="task_task_name">
            <label for="task_description">詳細</label>
            <input v-model="task.description" type="text" name="task[description]" id="task_description">
            <label for="task_due_date">期限日</label>
            <input v-model="task.due_date" type="date" name="task[due_date]" id="task_due_date">
            <button type="submit" name="commit" @click="submitTask">登録</button>
        </form>
    </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: () => {
      return {
        task: {
          id: '',
          task_name: '',
          description: '',
          due_date: '',
          user_id: ''
        },
        csrfToken: ''
      }
    },
    methods: {
      //setCsrfToken() {
      //  axios.get('/tasks/new').then((response) => {
      //    this.csrfToken = document.getElementsByName('csrf-token')[0].content;
      //    debugger;
      //    this.task.user_id = response.data.user_id
      //  }).catch((response) => {
      //    console.log(response);
      //  });
      //},
      submitTask: function () {
        let config = {
          headers: {
            'content-type': 'application/json',
          }
        };
        //if (process.env.RAILS_ENV != "test") {
          // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
       //   axios.defaults.headers['X-CSRF-TOKEN'] = this.csrfToken;
        //}
        let params = {
          'task': this.task
        };
        axios
          .post('/tasks', params, config)
          .then((response) => {})
          .catch((response) => {
          console.log(response);
        });
      }
    }
  }
</script>