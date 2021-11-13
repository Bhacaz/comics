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
      <p class="subtitle">Nice design for <em>readcomicsonline.ru</em></p>
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
    <div v-if="getProgression()">
      <h6 class="title is-6">Continue Reading</h6>
      <div class="columns is-mobile">
        <ComicCover
          v-for="[comicId, progression] of Object.entries(getProgression())"
          :key="comicId"
          :comicId="comicId"
          :progressionInfo="progression"
          class="column"
        ></ComicCover>
      </div>
    </div>
  </section>
</template>

<script>
import Progression from "@/models/progressionService";
import ComicCover from "@/components/progression/ComicCover";
export default {
  name: "Home",
  components: { ComicCover },
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
          this.searchResults = result.slice(0, 50);
        });
    });
  },
};
</script>

<style>
.hero.is-warning {
  background-color: #fbe34c;
}

.progression-covers {
  flex-wrap: wrap;
}
</style>
