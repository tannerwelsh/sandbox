<template>
  <div class="home">
    <div v-show="showVideo">
      <!-- <video ref="video" autoplay muted playsinline width="250"> -->
      <video ref="video" controls playsinline width="500" @play="playback">
        <track kind="subtitles" srclang="en" :src="vttFile" default />
      </video>
    </div>
    <textarea v-model="text" @input="textareaChanged"></textarea>

    <span v-show="isRecording">Recording!</span>
    <!-- <button @click="save">Save</button> -->
    <!-- <button @click="playback">Playback</button> -->
    <button @click="record">Record</button>
    <button @click="save">Stop</button>
    <!-- <a ref="download" href="#">Download</a>
    <a ref="downloadvtt" href="#">Download VTT</a> -->
  </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from "vuex";
import store from "@/store";

// store.subscribeAction((action, state) => {});

let mediaRecorder;
let recordedChunks;

export default {
  name: "Home",
  data() {
    return {
      text: "edit me",
      vttFile: null,
      showVideo: false,
      shouldStop: false,
      stopped: false
    };
  },
  computed: {
    ...mapState(["changeHistory"]),
    ...mapGetters(["isRecording", "timeElapsed"])
  },
  methods: {
    ...mapActions(["startRecording", "saveRecording"]),
    textareaChanged() {
      store.dispatch("recordChange", this.text);
    },
    playback() {
      this.text = "edit me";
      this.changeHistory.forEach(change => {
        setTimeout(() => {
          this.text = change.newValue;
        }, change.relativeTime);
      });
    },
    record() {
      this.startRecording();
      this.recordAudio();
    },
    save() {
      this.stopAudio();
      this.saveRecording();
      this.makeVTT();
      // this.$refs.downloadvtt.href = URL.createObjectURL(new Blob([histories]));
      // this.$refs.downloadvtt.download = "acetest.vtt";
    },

    makeVTT() {
      // WEBVTT
      //
      // 1
      // 00:00:01.890 --> 00:00:02.850
      // There was a table set

      const convertMS = ms => {
        const [secs, millisecs] = (ms / 1000).toString().split(".");
        return `00:00:0${secs}.${millisecs}`;
      };

      let vtt = ["WEBVTT", ""];

      this.changeHistory.forEach((change, index) => {
        const nextChange = this.changeHistory[index + 1];
        const timeStart = convertMS(change.relativeTime);
        const timeEnd = nextChange
          ? convertMS(nextChange.relativeTime)
          : convertMS(this.timeElapsed);

        const timeRange = `${timeStart} --> ${timeEnd}`;
        vtt.push(timeRange);
        vtt.push(change.newValue);
        vtt.push("");
      });

      vtt = vtt.join("\n");
      console.log("makeVTT -> vtt", vtt);

      this.vttFile = URL.createObjectURL(new Blob([vtt]));
    },

    stopAudio() {
      mediaRecorder.stop();
      // this.showVideo = true;
      // this.$refs.video.src = URL.createObjectURL(new Blob(recordedChunks));
    },
    recordAudio() {
      // const downloadLink = this.$refs.download;

      const handleSuccess = stream => {
        // this.$refs.video.srcObject = stream;
        const options = { mimeType: "video/webm" };
        recordedChunks = [];
        mediaRecorder = new MediaRecorder(stream, options);

        mediaRecorder.addEventListener("dataavailable", e => {
          if (e.data.size > 0) {
            recordedChunks.push(e.data);
          }
        });

        mediaRecorder.addEventListener("stop", () => {
          this.showVideo = true;
          console.log("recordAudio -> this.showVideo", this.showVideo);
          this.$refs.video.src = URL.createObjectURL(new Blob(recordedChunks));
          // downloadLink.href = URL.createObjectURL(new Blob(recordedChunks));
          // downloadLink.download = "acetest.webm";
        });

        mediaRecorder.start();
        // mediaRecorder.state
      };

      navigator.mediaDevices
        .getUserMedia({ audio: true, video: true })
        .then(handleSuccess);
    }
  }
};
</script>

<style>
textarea {
  width: 100%;
  height: 240px;
}
</style>
