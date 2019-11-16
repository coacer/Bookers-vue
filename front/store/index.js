export const strict = false

export const state = () => ({
  user: null,
  navList: [
    {
      name: 'Books',
      path: '/'
    },
    {
      name: 'New',
      path: '/books/new'
    },
    {
      name: 'Login',
      path: '/users/signin'
    }
  ]
})

export const mutations = {
  setUser (state, payload) {
    state.user = payload
  },
  addNavList(state, payload) {
    state.navList.push(payload);
  },
  removeNavList(state) {
    state.navList.pop();
  }
}

export const actions = {
  setUser ({ commit }, payload) {
    commit('setUser', payload)
  }
}

export const getters = {
  isAuthenticated (state) {
    return !!state.user
  }
}
