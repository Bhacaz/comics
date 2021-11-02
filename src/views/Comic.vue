<template>
  <section class="section">
    <div v-if="comicData" class="columns">
      <div class="column is-one-third">
        <img v-bind:src="comicData.cover" />
      </div>
      <div class="column">
        <div>
          <h2 class="title is-2">{{ comicData.title }}</h2>
        </div>
        <div><strong>Summary:</strong> {{ comicData.summary }}</div>
        <div><strong>Release:</strong> {{ comicData.date_of_release }}</div>
        <div><strong>Rating:</strong> {{ comicData.rating }}/5</div>
        <div><strong>Status:</strong> {{ comicData.status }}</div>
      </div>
    </div>
  </section>
  <section class="section">
    <p v-for="chapter of comicData.chapters" v-bind:key="chapter.number">
      <router-link
        :to="'/reader/' + comicData.id + '/' + chapter.number + '/1'"
      >
        {{ chapter.name }}
      </router-link>
    </p>
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

<style></style>
