<template>
    <div>
        <h1>ログイン</h1>
        <form class="new_session" id="new_session" accept-charset="UTF-8" method="post" action="/auth/sign_in">
            <label for="session_email">Eメール</label>
            <input v-model="email" type="email" name="email" id="session_email">
            <label for="session_password">パスワード</label>
            <input v-model="password" type="text" name="password" id="session_password">
            <button type="submit" name="commit" @click="submitSessionParams">登録</button>
        </form>
    </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: () => {
      return {
        email: '',
        password: '',
        token: ''
      }
    },
    methods: {
      submitSessionParams: function () {
        let config = {
          headers: {
            'content-type': 'application/json'
          }
        };
        //if (process.env.RAILS_ENV != "test") {
        // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
        //   axios.defaults.headers['X-CSRF-TOKEN'] = this.csrfToken;
        //}
        axios
          .post('/auth/sign_in', {email: this.email, password: this.password}, config)
          .then((response) => {
            localStorage.setItem('access-token', response.headers['access-token']);
            debugger;
          })
          .catch((response) => {
            console.log(response);
          });
      }
    }
  }
</script>