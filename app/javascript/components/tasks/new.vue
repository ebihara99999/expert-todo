<template>
    <div>
        <h1>新規作成</h1>
        <div class="new_task" id="new_task">
            <label for="task_task_name">タスク名</label>
            <input v-model="task.task_name" type="text" name="task[task_name]" id="task_task_name">
            <label for="task_description">詳細</label>
            <input v-model="task.description" type="text" name="task[description]" id="task_description">
            <label for="task_due_date">期限日</label>
            <input v-model="task.due_date" type="date" name="task[due_date]" id="task_due_date">
            <button type="submit" name="commit" @click="submitTask">登録</button>
        </div>
    </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: () => {
      return {
        task: {
          task_name: '',
          description: '',
          due_date: '',
        },
      }
    },
    methods: {
      submitTask: function () {
        let config = {
          headers: {
            'content-type': 'application/json',
            'Authorization': localStorage.getItem('auth-token')
          }
        };

        let params = {
          'task': this.task
        };

        if (process.env.RAILS_ENV != "test") {
          // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
          axios.defaults.headers['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].content;
        }

        axios
          .post('/tasks', params, config)
          .then(() => {
            this.$router.push('/tasks')
          })
          .catch((response) => {
            console.log(response);
            this.$router.push('/'); //認証失敗の場合
        });
      }
    }
  }
</script>