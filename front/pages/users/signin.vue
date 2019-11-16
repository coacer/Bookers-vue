<template>
  <div>
    <!-- ログイン中に表示される画面 -->
    <div v-if="isAuthenticated">
      {{ user.email }}でログイン中です<br>
      <button v-on:click="logout">ログアウト</button><br>
      <a href="/member-page">メンバーページへ</a>
    </div>
    <!-- ログインしていない時に表示される画面 -->
    <div v-else>
      <v-card width="50%" class="mx-auto mt-5">
        <v-card-title>Sign In</v-card-title>
        <v-card-text>
          <v-form>
            <v-text-field v-model="email" prepend-icon="mdi-email" label="Email"/>
              <v-text-field v-model="password" @click:append="showPassword = !showPassword" prepend-icon="mdi-lock" :append-icon="showPassword ? 'mdi-eye-off' : 'mdi-eye'" :type="showPassword ? 'text' : 'password'" label="Password"/>
                <v-card-actions>
                  <v-btn class="info" @click="login">Sign In</v-btn>
                </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
    </div>
  </div>
</template>

<script>
import firebase from '~/plugins/firebase'
import { mapActions, mapState, mapGetters, mapMutations } from 'vuex'

export default {
  data() {
    return {
      email: '',
      password: '',
      showPassword: false
    }
  },
  computed: {
    ...mapState(['user', 'navList']),
    ...mapGetters(['isAuthenticated']),
  },
  mounted() {
    firebase.auth().onAuthStateChanged((user) => {
      this.setUser(user)
    })
  },
  methods : {
    ...mapActions(['setUser']),
    ...mapMutations(['removeNavList']),
    login() {
        this.$nuxt.$loading.start();
        firebase.auth().signInWithEmailAndPassword(this.email, this.password)
          .then(user => {
            this.removeNavList();
            this.$router.push('/');
            this.$nuxt.$loading.finish();
          }).catch((error) => {
            alert(error)
          }).finally(() => {
            this.$nuxt.$loading.finish();
          });
    },
    logout() {
      firebase.auth().signOut()
        .then(() => {
          this.setUser(null)
        }).catch((error) => {
          alert(error)
        })
    }
  }
}
</script>
