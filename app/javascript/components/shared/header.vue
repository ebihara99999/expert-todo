<template>
    <v-navigation-drawer permanent dark class="blue lighten-3" width="100%" height="6%">
        <v-list>
            <v-list-tile>
                <v-list-tile-content>
                    <router-link :to="{ name: 'rootPath'}">TOP</router-link>
                </v-list-tile-content>
                <v-list-tile-content>
                    <router-link :to="{ name: 'newSessionPath'}">ログイン</router-link>
                </v-list-tile-content>
                <v-list-tile-content>
                    <router-link :to="{ name: 'tasksPath'}">タスク一覧</router-link>
                </v-list-tile-content>
            </v-list-tile>
        </v-list>
    </v-navigation-drawer>
</template>