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
  created() {
    axios.get('/api/v1/books')
      .then(res => {
        this.books = res.data;
      });
  }
}
</script>

<style>

</style>
