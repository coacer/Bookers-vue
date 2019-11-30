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
        <template v-else>
          <v-btn text to="/users/signin" nuxt>Login</v-btn>
          <v-btn text to="/users/signup" nuxt>Sign up</v-btn>
        </template>
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
    ...mapState(['userId']),
  },
  created() {
    setTimeout(() => {
      console.log("userId: ", this.userId);
      this.navItems.push({
        name: 'My page',
        path: {
          name: 'users-id',
          params: { id: this.userId }
        }
      });
    }, 0);
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
