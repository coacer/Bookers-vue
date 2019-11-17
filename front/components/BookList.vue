<template>
  <v-simple-table>
    <template v-slot:default>
      <thead>
        <tr>
          <th class="text-left">Title</th>
          <th class="text-left">Opinion</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="book in books" :key="book.id">
          <nuxt-link :to="`/books/${book.id}`" tag="td" style="cursor: pointer;">{{ book.title }}</nuxt-link>
          <td>{{ book.body }}</td>
        </tr>
      </tbody>
    </template>
  </v-simple-table>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      books: [],
    }
  },
  async created() {
    const { data } = await axios.get('/api/v1/books');
    this.books = data;
  }
}
</script>

<style>

</style>
