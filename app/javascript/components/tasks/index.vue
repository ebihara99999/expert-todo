<template>
    <div>
        <h1>タスク一覧</h1>
        <h2><router-link :to="{ name: 'newTaskPath'}">タスクの新規作成</router-link></h2>
        <table>
            <thead>
            <tr>
                <th>タスク名</th>
                <th>詳細</th>
                <th>期限日</th>
                <th>作成日</th>
                <th>更新日</th>
                <th>編集</th>
                <th>ファイルを添付</th>
                <th>添付ファイル一覧</th>
                <th>終了済みへ変更</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="task in tasks">
                <td>{{ task.task_name }}</td>
                <td>{{ task.description }}</td>
                <td>{{ task.due_date }}</td>
                <td>{{ task.created_at }}</td>
                <td>{{ task.updated_at }}</td>
                <td><router-link :to="{ name: 'editTaskPath', params: { id: task.id }}">編集</router-link></td>
                <td><router-link :to="{ name: 'newTaskFilePath', params: { task_id: task.id } }">ファイル添付</router-link></td>
                <td><router-link :to="{ name: 'taskFilesPath', params: { task_id: task.id } }">ファイル一覧</router-link></td>
                <td><router-link :to="{ name: 'taskEndPath' }">終了済みへ変更</router-link></td>
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
        tasks: []
      }
    },
    created() {
      this.setTasks();
    },
    methods: {
      setTasks() {
        axios.get('/tasks').then((response) => {
          this.tasks = response.data.tasks;
        }).catch((response) => {
          console.log(response.error);
        });
      }
    }
  }
</script>