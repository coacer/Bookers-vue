<template>
  <v-card>
    <slot name="user-image"></slot>
    <v-card-text><slot name="user-name">ユーザー名</slot></v-card-text>
    <v-card-title class="display-1">
      <slot name="book-title">タイトル</slot>
    </v-card-title>
    <v-card-text><slot name="book-body">コンテント</slot></v-card-text>
    <slot></slot>
  </v-card>
</template>

<script>
export default {
}
</script>

<style>

</style>
