export const strict = false

export const state = () => ({
  user: null,
  userId: null,
})

export const mutations = {
  setUser (state, payload) {
    state.user = payload;
  },
  setUserId(state, payload) {
    state.userId = payload;
  }
}

export const actions = {
  setUser ({ commit }, payload) {
    commit('setUser', payload);
  },
  setUserId ({ commit }, payload) {
    commit('setUserId', payload);
  },
}

export const getters = {
  isAuthenticated (state) {
    return !!state.user;
  }
}
