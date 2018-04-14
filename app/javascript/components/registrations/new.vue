<template>
  <div>
    <v-card
      color="grey lighten-4"
      flat
    >
      <h1>ユーザー作成</h1>
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
              id="user_email"
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
              id="user_password"
              v-model="password"
            />
          </v-flex>
        </v-layout>
        <v-layout row>
          <v-flex xs4>
            <v-subheader>パスワード確認</v-subheader>
          </v-flex>
          <v-flex xs8>
            <v-text-field
              type="password"
              name="passwordConfirmation"
              label="passwordConfirmation"
              id="user_passwordConfirmation"
              v-model="passwordConfirmation"
            />
          </v-flex>
        </v-layout>
        <v-card-actions>
          <v-btn
            color="primary"
            flat
            @click="submitRegistrationParams"
          >
            ユーザー作成
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
        passwordConfirmation: '',
      };
    },
    methods: {
      submitRegistrationParams: function() {
        let config = {
          headers: {
            'content-type': 'application/json',
          },
        };

        let registrationParams = {
          'user': {
            'email': this.email,
            'password': this.password,
            'passwordConfirmation': this.passwordConfirmation,
          },
        };

        if (process.env.RAILS_ENV != 'test') {
          // テストだとdocument.getElementsByName('csrf-token')[0]が取得できず、エラーが起きる
          axios.defaults.headers['X-CSRF-TOKEN'] =
            document.getElementsByName('csrf-token')[0].content;
        }

        axios
          .post('/api/v1/users/registrations', registrationParams, config)
          .then((response) => {
            localStorage.setItem('auth-token', response.data.auth_token);
            this.$router.push($newSessionPath);
          })
          .catch((response) => {
            console.log(response);
          });
      },
    },
  };
</script>
