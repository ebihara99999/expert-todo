<template>
  <v-navigation-drawer
    permanent
    dark
    class="blue lighten-3"
    width="100%"
    height="6%"
  >
    <v-list>
      <v-list-tile>
        <v-list-tile-content>
          <router-link :to="{ name: 'rootPath'}">TOP</router-link>
        </v-list-tile-content>
        <v-list-tile-content>
          <button v-if='this.$store.getters.isLogin' v-on:click='deleteToken'>ログアウト</button>
          <router-link v-else :to="{ name: 'newSessionPath'}">ログイン</router-link>
        </v-list-tile-content>
        <v-list-tile-content>
          <router-link :to="{ name: 'newUserPath'}">ユーザー作成</router-link>
        </v-list-tile-content>
        <v-list-tile-content>
          <router-link :to="{ name: 'tasksPath'}">タスク一覧</router-link>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
  export default {
    methods: {
      deleteToken: function() {
        let config = {
          headers: {
            'content-type': 'application/json',
          },
        };
        localStorage.removeItem('auth-token');
        this.$store.commit('logout');
        this.$router.push('/');
      },
      setToken: function() {
        localStorage.setItem('auth-token', "hogehoge");
        this.$store.commit('login');
      }
    },
  };
</script>