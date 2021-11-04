<template>
  <section class="section" id="comic-data-section">
    <div v-if="comicData" class="columns">
      <div class="column is-one-third">
        <img v-bind:src="comicData.cover" />
      </div>
      <div class="column">
        <div>
          <h2 class="title is-2" id="comic-title">{{ comicData.title }}</h2>
        </div>
        <div><strong>Summary: </strong> {{ comicData.summary }}</div>
        <div><strong>Type: </strong> {{ comicData.type }}</div>
        <div><strong>Release: </strong> {{ comicData.date_of_release }}</div>
        <div><strong>Rating: </strong> {{ comicData.rating }}/5</div>
        <div><strong>Status: </strong> {{ comicData.status }}</div>
        <div>
          <strong>Source: </strong>
          <a v-bind:href="`https://readcomicsonline.ru/comic/${comicData.id}`"
            >Read Comics Online</a
          >
        </div>
      </div>
    </div>
  </section>
  <section v-if="comicData" class="section" id="chapters">
    <router-link
      class="button chapter-link"
      v-for="chapter of comicData.chapters"
      v-bind:key="chapter.number"
      :to="'/reader/' + comicData.id + '/' + chapter.number + '/1'"
    >
      #{{ chapter.number }}
    </router-link>
  </section>
</template>

<script>
export default {
  name: "Comic",
  data() {
    return {
      comicData: null,
    };
  },
  created() {
    this.fetchComicData();
  },
  methods: {
    fetchComicData() {
      fetch(
        process.env.VUE_APP_BASE_API + "/api/comic?id=" + this.$route.params.id
      )
        .then((res) => res.json())
        .then((result) => {
          this.comicData = result;
        });
    },
  },
};
</script>

<style>
.chapter-link {
  margin: 0.5em;
}

#chapters {
  display: flex;
  flex-wrap: wrap;
}

#comic-title {
  padding-bottom: 1em;
}

#comic-data-section {
  background: linear-gradient(180deg, #fbe34c 30%, #ffffff 30%);
}
</style>
