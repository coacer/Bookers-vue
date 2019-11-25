<template>
  <v-card class="pa-10 mx-auto mt-10" width="50%">
    <v-container>
      <h2>User Show</h2>
      <v-img
        src="/no_image.jpg"
        width="100px"
        height="100px"
        ></v-img>
      <v-card-title>{{ user.name }}</v-card-title>
      <v-card-text>{{ user.email }}</v-card-text>
      <v-card-actions v-show="userId !== user.id">
        <v-btn :to="{name: 'chat-userId', params: { userId: user.id }}" class="info" nuxt><v-icon>mdi-email</v-icon>DM</v-btn>
      </v-card-actions>
    </v-container>
  </v-card>

</template>

<script>
import { mapState } from 'vuex';

export default {

  computed: {
    ...mapState(['userId']),
  },

  data() {
    return {
      user: {},
    }
  },

  async created() {
    const { data } = await this.$axios.get(`/api/v1/users/${this.$route.params.id}`);
    this.user = data;
  },

}
</script>

<style>

</style>
