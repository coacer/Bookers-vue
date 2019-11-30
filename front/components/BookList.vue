<template>
  <v-layout wrap>
    <v-flex xs4 v-for="book in books" :key="book.id">

      <base-book class="ma-4">
        <template v-slot:user-image>
          <v-img
            :src="book.user.profile_image_url"
            aspect-ratio="1"
            class="grey lighten-2"
            max-width="50"
            max-height="50"
          ></v-img>
        </template>
        <template v-slot:user-name>
          <nuxt-link :to="{ name: 'users-id', params: { id: book.user.id } }">
            {{ book.user.name }}
          </nuxt-link>
        </template>
        <template v-slot:book-title>{{ book.title }}</template>
        <template v-slot:book-body>{{ book.body }}</template>
        <v-card-actions>
          <v-btn :to="`/books/${book.id}`" class="grey white--text" nuxt>show</v-btn>
        </v-card-actions>
      </base-book>

    </v-flex>
  </v-layout>
</template>

<script>
import BaseBook from '~/components/BaseBook.vue';

export default {

  components: {
    BaseBook,
  },

  data() {
    return {
      books: [],
    }
  },

  async created() {
    const { data } = await this.$axios.get('/api/v1/books');
    this.books = data;
  },

}
</script>

<style>

</style>
