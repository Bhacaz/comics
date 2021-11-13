<template>
  <div class="image-container" v-if="show">
    <img v-bind:src="coverUrl" class="image-comic" @click="goToReader()" />
    <div class="info">
      <div>
        {{
          `#${this.progressionInfo.chapterId} p.${this.progressionInfo.pageNumber}`
        }}
      </div>
      <div>
        <button class="delete" @click="removeFromProgressionList()"></button>
      </div>
    </div>
  </div>
</template>

<script>
import Progression from "@/models/progressionService";

export default {
  name: "ComicCover",
  props: ["comicId", "progressionInfo"],
  data() {
    return {
      coverUrl: null,
      show: true,
    };
  },
  methods: {
    fetchCoverUrl() {
      fetch(process.env.VUE_APP_BASE_API + "/api/comic?id=" + this.comicId)
        .then((res) => res.json())
        .then((result) => (this.coverUrl = result.cover));
    },
    goToReader() {
      this.$router.push(`/comic/${this.comicId}`).then(() => {
        this.$router.push(
          `/reader/${this.comicId}/${this.progressionInfo.chapterId}/${this.progressionInfo.pageNumber}`
        );
      });
    },
    removeFromProgressionList() {
      Progression.removeProgression(this.comicId);
      this.show = false;
    },
  },
  created() {
    this.fetchCoverUrl();
  },
};
</script>

<style>
.image-container {
  /*display: grid;*/
  max-width: 8em;
  position: relative;
}

.image-comic,
.info {
  /*grid-area: 1 / 1;*/
}

.info {
  position: absolute;
  bottom: 0;
  width: 100%;
  background: linear-gradient(
    0deg,
    rgba(255, 255, 255, 1) 50%,
    rgba(25, 118, 210, 0) 100%
  );
  justify-content: space-between;
  display: flex;
  padding-left: 0.5em;
  padding-right: 1em;
}
</style>
