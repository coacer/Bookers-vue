<template>
  <div>
    <v-toolbar dark>
      <v-toolbar-title>Bookers</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-toolbar-items>
        <template v-for="item in navItems">
          <v-btn text :to="item.path" :key="item.name" nuxt>
            {{ item.name }}
          </v-btn>
        </template>
        <v-btn text v-if="isAuthenticated" @click="logout">Logout</v-btn>
        <v-btn text to="/users/signin" v-else nuxt>Login</v-btn>
      </v-toolbar-items>

    </v-toolbar>
  </div>
</template>

<script>
import firebase from '~/plugins/firebase'
import { mapGetters, mapState, mapActions } from 'vuex';

export default {
  data() {
    return {
      navItems: [
        {
          name: 'Books',
          path: '/'
        },
        {
          name: 'New',
          path: '/books/new'
        },
      ]

    }
  },
  computed: {
    ...mapGetters(['isAuthenticated']),
    // ...mapState(['navList']),
  },
  methods: {
    // ...mapMutations(['addNavList']),
    ...mapActions(['setUser']),
    logout() {
      firebase.auth().signOut()
        .then(() => {
          // this.addNavList({
          //   name: 'Login',
          //   path: '/users/signin'
          // });
          this.setUser(null)
          this.$router.push('/users/signin');
        }).catch((error) => {
          alert(error)
        })
    }

  }
}
</script>

<style>

</style>
