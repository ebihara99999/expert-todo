<template>
    <div>
        <h1>編集</h1>
        <div class="new_task" id="new_task" accept-charset="UTF-8">
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
          id: '',
          task_name: '',
          description: '',
          due_date: '',
          user_id: ''
        },
        csrfToken: ''
      }
    },
    created() {
      this.setTask();
    },
    methods: {
      setTask() {
        axios.get(this.$route.path).then((response) => {
          this.task.id = response.data.id;
          this.task.user_id = response.data.user_id;
          this.task.task_name = response.data.task_name;
          this.task.description = response.data.description;
          this.task.due_date = response.data.due_date;
        }).catch((response) => {
          console.log(response);
        });
      },
      submitTask: function () {
        let config = {
          headers: {
            'content-type': 'application/json'
          },
        };
        axios
          .patch(`/tasks/${this.task.id}`, this.task, config)
          .then((response) => {
          })
          .catch((response) => {
            console.log(response);
          });
      }
    }
  }
</script>