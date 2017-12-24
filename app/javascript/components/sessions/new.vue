<template>
    <div>
        <h1>ログイン</h1>
        <div class="new_session" id="new_session">
            <label for="session_email">Eメール</label>
            <input v-model="email" type="email" name="email" id="session_email">
            <label for="session_password">パスワード</label>
            <input v-model="password" type="text" name="password" id="session_password">
            <button type="submit" name="commit" @click="submitSessionParams">登録</button>
        </div>
    </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: () => {
      return {
        email: '',
        password: '',
      }
    },
    methods: {
      submitSessionParams: function () {
        let config = {
          headers: {
            'content-type': 'application/json',
          }
        };

        let sessionParams = {
          'session': {
            'email': this.email,
            'password': this.password
          }
        };

        if (process.env.RAILS_ENV != "test") {
          // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
          axios.defaults.headers['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].content;
        }

        axios
          .post('/users/sessions', sessionParams, config)
          .then((response) => {
            localStorage.setItem('auth-token', response.data.auth_token);
            this.$router.push('/')
          })
          .catch((response) => {
            console.log(response);
          });
      }
    }
  }
</script>