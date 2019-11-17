<template>
  <v-form v-model="valid">
    <v-container>
      <v-card class="pa-10" min-height="400px">
        <v-card-title>{{ type }} Book</v-card-title>
        <v-text-field
          v-model="title"
          :rules="titleRules"
          :counter="10"
          label="Title"
          required
          ></v-text-field>

        <v-text-field
          v-model="body"
          :rules="bodyRules"
          :counter="50"
          label="Opinion"
          required
          ></v-text-field>

        <v-btn absolute right bottom @click="submitHandler">{{ type === "new" ? "Create!" : "Update!" }}</v-btn>
      </v-card>
    </v-container>
  </v-form>

</template>

<script>
import { mapState } from 'vuex';

export default {
  props: {
    type: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      valid: false,
      title: '',
      titleRules: [
        v => !!v || 'title is required',
        v => v.length <= 10 || 'Title must be less than 10 characters',
      ],
      body: '',
      bodyRules: [
        v => !!v || 'Opinion is required',
        v => v.length <= 50 || 'Opinion must be less than 50 characters',
      ],

    }
  },
  computed: {
    ...mapState(['userId']),
  },
  async mounted() {
    if(this.type === "edit") {
      const { data } = await this.$axios.get(`/api/v1/books/${this.$route.params.id}`);
        this.title = data.title;
        this.body = data.body;
    }
  },
  methods: {
    submitHandler() {
      this.type === "new" ? this.newBook() : this.editBook()
    },
    async newBook() {
      const { data } = await this.$axios.post('/api/v1/books', {
        book: {
          title: this.title,
          body: this.body,
          user_id: this.userId
        }
      });
      if(data.status === 200) {
        this.$router.push({
          name: "books-id",
          params: {
            id: data.book.id
          }
        });
      } else {
        console.log(data.message);
      }
    },
    async editBook() {
      const { data } = await this.$axios.patch(`/api/v1/books/${this.$route.params.id}`, {
        book: {
          title: this.title,
          body: this.body
        }
      });
      if(data.status === 200) {
        this.$router.push({
          name: "books-id",
          params: {
            id: data.book.id
          }
        });
      } else {
        console.log(data.message);
      }
    }
  }
}
</script>

<style>

</style>
