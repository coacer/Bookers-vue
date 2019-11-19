<template>
  <members-only>
    <v-card class="mx-auto">
      <v-container class="px-10">
        <h2>Book Details</h2>
        <v-card-title>{{ book.title }}</v-card-title>
        <v-card-text>{{ book.body }}</v-card-text>
        <v-btn :to="`/books/${book.id}/edit`" nuxt>Edit</v-btn>
        <v-btn @click="deleteBook">Delete</v-btn>
      </v-container>
    </v-card>
  </members-only>
</template>

<script>
import MembersOnly from '~/components/MembersOnly';

export default {

  validate({ params }) {
    return /^\d+$/.test(params.id);
  },

  components: {
    MembersOnly
  },

  async created() {
    const { data } = await this.$axios.get(`/api/v1/books/${this.$route.params.id}`);
    this.book = data;
  },

  data() {
    return {
      book: {}
    }
  },

  methods: {
    async deleteBook() {
      await this.$axios.delete(`/api/v1/books/${this.book.id}`);
      this.$router.push({ name: 'index' });
    }
  },

}
</script>

<style>

</style>
