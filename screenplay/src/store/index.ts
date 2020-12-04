import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

type Change = {
  newValue: string
  relativeTime: number,
}

interface State {
  changeHistory: Change[],
  startRecordTime?: Date,
  endRecordTime?: Date,
}

const defaultState = (): State => {
  return {
    changeHistory: [],
    startRecordTime: undefined,
    endRecordTime: undefined
  }
}

export default new Vuex.Store({
  state: defaultState(),
  getters: {
    isRecording: s => s.startRecordTime && !s.endRecordTime,
    timeElapsed: s => {
      return s.startRecordTime && s.endRecordTime
        ? (s.endRecordTime.valueOf() - s.startRecordTime.valueOf())
        : 0
    }
  },
  mutations: {
    addChange(state, change: Change) {
      state.changeHistory.push(change)
    },
    startRecording(state, time) {
      state.startRecordTime = time
    },
    finishRecording(state, time) {
      state.endRecordTime = time
    }
  },
  actions: {
    recordChange({ commit, state }, newValue) {
      const relativeTime = state.startRecordTime
        ? (new Date()).valueOf() - state.startRecordTime.valueOf()
        : 0

      commit('addChange', {
        newValue,
        relativeTime
      })
    },
    startRecording({ commit }) {
      commit('startRecording', new Date())
    },
    saveRecording({ commit }) {
      commit('finishRecording', new Date())
    },
  },
  modules: {}
});
