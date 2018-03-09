<template>
  <div>
    <h1>タスク一覧</h1>
    <h2>
      <router-link :to="{ name: 'newTaskPath'}">タスクの新規作成</router-link>
    </h2>

    <v-data-table
      :headers="headers"
      :items="items"
      hide-actions
      class="elevation-1"
    >
      <template
        slot="items"
        scope="props"
      >
        <td class="text-xs-right">
          <router-link :to="{ name: 'editTaskPath', params: {id: props.item.id} }">編集</router-link>
        </td>
        <td class="text-xs-right">{{ props.item.task_name }}</td>
        <td class="text-xs-right">{{ props.item.description }}</td>
        <td class="text-xs-right">{{ props.item.due_date }}</td>
        <td class="text-xs-right">{{ props.item.created_at }}</td>
        <td class="text-xs-right">
          <router-link :to="{ name: 'taskFilesPath', params: {taskId: props.item.id} }">
            ファイル一覧
          </router-link>
        </td>
        <td class="text-xs-right">
          <v-btn
            color="primary"
            @click.native="makeTaskEnd(props.item.id)"
          >
            終了済みへ変更
          </v-btn>
        </td>
      </template>
    </v-data-table>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: () => {
      return {
        items: [],
        headers: [
          {text: '編集', value: ''},
          {text: 'タスク名', value: 'task_name', sortable: true},
          {text: '詳細', value: 'description', sortable: true},
          {text: '期限', value: 'due_date', sortable: true},
          {text: '作成日', value: 'created_at', sortable: true},
          {text: 'ファイル一覧', value: ''},
          {text: 'タスクの終了', value: ''},
        ],
      };
    },
    created() {
      this.fetchTasks();
    },
    methods: {
      makeTaskEnd(taskId) {
        let config = {
          headers: {
            'content-type': 'application/json',
            'Authorization': localStorage.getItem('auth-token'),
          },
        };

        let params = {
          'id': taskId,
        };

        if (process.env.RAILS_ENV != 'test') {
          // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
          axios.defaults.headers['X-CSRF-TOKEN'] =
            document.getElementsByName('csrf-token')[0].content;
        }

        axios.post('/api/v1/tasks/task_end', params, config).then(() => {
          this.$router.push('/tasks');
        }).catch((response) => {
          console.log(response);
          this.$router.push('/');
        });
      },

      fetchTasks() {
        let config = {
          headers: {
            'content-type': 'application/json',
            'Authorization': localStorage.getItem('auth-token'),
          },
        };

        if (process.env.RAILS_ENV != 'test') {
          // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
          axios.defaults.headers['X-CSRF-TOKEN'] =
            document.getElementsByName('csrf-token')[0].content;
        }

        axios.get('/api/v1/tasks', config).then((response) => {
          this.items = response.data.tasks;
        }).catch((response) => {
          console.log(response);
          this.$router.push('/'); // 認証失敗の場合
        });
      },
    },
  };
</script>
