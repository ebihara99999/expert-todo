<template>
  <v-card
    color="grey lighten-4"
    flat
  >
    <h1>新規作成</h1>
    <v-container fluid>
      <v-layout row>
        <v-flex xs4>
          <v-subheader>タスク名</v-subheader>
        </v-flex>
        <v-flex xs8>
          <v-text-field
            type="text"
            name="task[task_name]"
            label="資料の作成"
            id="task_task_name"
            v-model="task.task_name"
          />
        </v-flex>
      </v-layout>

      <v-layout row>
        <v-flex xs4>
          <v-subheader>詳細</v-subheader>
        </v-flex>
        <v-flex xs8>
          <v-text-field
            type="text"
            name="task[description]"
            label="ExpertTodoの資料を作成する。"
            id="task_task_description"
            v-model="task.description"
          />
        </v-flex>
      </v-layout>

      <v-layout row>
        <v-flex xs4>
          <v-subheader>期限日</v-subheader>
        </v-flex>
        <v-flex xs8>
          <v-text-field
            type="date"
            name="task[due_date]"
            id="task_task_due_date"
            v-model="task.due_date"
          />
        </v-flex>
      </v-layout>

      <v-card-actions>
        <v-btn
          color="primary"
          flat
          @click="submitTask"
        >
          作成
        </v-btn>
      </v-card-actions>
    </v-container>
  </v-card>
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
      };
    },
    methods: {
      submitTask: function() {
        let config = {
          headers: {
            'content-type': 'application/json',
            'Authorization': localStorage.getItem('auth-token'),
          },
        };

        let params = {
          'task': this.task,
        };

        if (process.env.RAILS_ENV != 'test') {
          // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
          axios.defaults.headers['X-CSRF-TOKEN'] =
            document.getElementsByName('csrf-token')[0].content;
        }

        axios
          .post('/api/v1/tasks', params, config)
          .then(() => {
            this.$router.push('/tasks');
          })
          .catch((response) => {
            console.log(response);
            this.$router.push('/'); // 認証失敗の場合
        });
      },
    },
  };
</script>
