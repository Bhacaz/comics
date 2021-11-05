<template>
  <section class="hero is-warning">
    <div class="hero-body">
      <p class="title">
        <img
          src="/img/manifest/icon-192x192-crop.png"
          width="100px"
          alt=""
        /><span style="margin-left: -30px">omics</span>
      </p>
      <p class="subtitle">Nice design from <em>readcomicsonline.ru</em></p>
    </div>
  </section>

  <section class="section">
    <input
      class="input is-rounded"
      type="text"
      placeholder="Search"
      v-model="search"
    />
    <nav class="panel">
      <router-link
        class="panel-block"
        v-for="result in searchResults"
        v-bind:key="result.data"
        :to="'/comic/' + result.data"
      >
        {{ result.value }}
      </router-link>
    </nav>
  </section>
  <section class="section" v-if="getProgression()">
    <p>Continue Reading</p>
    <p
      v-for="[comicId, progression] of Object.entries(getProgression())"
      v-bind:key="comicId"
    >
      <router-link
        :to="`/reader/${comicId}/${progression.chapterId}/${progression.pageNumber}`"
        >{{
          `${comicId} (chapter: ${progression.chapterId}, page: ${progression.pageNumber})`
        }}</router-link
      >
    </p>
  </section>
</template>

<script>
import Progression from "@/models/progressionService";

export default {
  name: "Home",
  components: {},
  data() {
    return {
      search: null,
      searchResults: [],
    };
  },
  methods: {
    ...Progression,
  },
  mounted() {
    this.$watch("search", () => {
      fetch(process.env.VUE_APP_BASE_API + "/api/search?query=" + this.search)
        .then((res) => res.json())
        .then((result) => {
          this.searchResults = result.slice(0, 10);
        });
    });
  },
};
</script>

<style>
.hero.is-warning {
  background-color: #fbe34c;
}
</style>
