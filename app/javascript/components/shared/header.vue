<template>
    <div id="expert-todo-header">
        <ul class="menu">
            <li><router-link :to="{ name: 'rootPath'}">TOP</router-link></li>
            <li><router-link :to="{ name: 'newSessionPath'}">ログイン</router-link></li>
            <li><router-link :to="{ name: 'tasksPath'}">タスク一覧</router-link></li>
        </ul>
    </div>
</template>