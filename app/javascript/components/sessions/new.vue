<template>
  <div>
    <v-card
      color="grey lighten-4"
      flat
    >
      <h1>ログイン</h1>
      <v-container fluid>
        <v-layout row>
          <v-flex xs4>
            <v-subheader>Eメール</v-subheader>
          </v-flex>
          <v-flex xs8>
            <v-text-field
              type="email"
              name="email"
              label="expert-todo@example.com"
              id="session_email"
              v-model="email"
            />
          </v-flex>
        </v-layout>

        <v-layout row>
          <v-flex xs4>
            <v-subheader>パスワード</v-subheader>
          </v-flex>
          <v-flex xs8>
            <v-text-field
              type="password"
              name="password"
              label="password"
              id="session_password"
              v-model="password"
            />
          </v-flex>
        </v-layout>
        <v-card-actions>
          <v-btn
            color="primary"
            flat
            @click="submitSessionParams"
          >
            ログイン
          </v-btn>
        </v-card-actions>
      </v-container>
    </v-card>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: () => {
      return {
        email: '',
        password: '',
      };
    },
    methods: {
      submitSessionParams: function() {
        let config = {
          headers: {
            'content-type': 'application/json',
          },
        };

        let sessionParams = {
          'session': {
            'email': this.email,
            'password': this.password,
          },
        };

        if (process.env.RAILS_ENV != 'test') {
          // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
          axios.defaults.headers['X-CSRF-TOKEN'] =
          document.getElementsByName('csrf-token')[0].content;
        }

        axios
          .post('/api/v1/users/sessions', sessionParams, config)
          .then((response) => {
            localStorage.setItem('auth-token', response.data.auth_token);
            this.$store.commit('login');
            this.$router.push('/');
          })
          .catch((response) => {
            console.log(response);
          });
      },
    },
  };
</script>
