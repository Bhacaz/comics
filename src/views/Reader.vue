<template>
  <div id="reader">
    <div id="image-container">
      <img class="page" v-bind:src="buffer.current().pageUrl" />
    </div>
    <div id="overlay-control">
      <div class="columns">
        <div
          id="top-control"
          class="column is-full"
          @click="toggleFullscreen()"
        ></div>
      </div>
      <div id="left-right-control-container" class="columns is-mobile">
        <div
          id="left-control"
          class="column is-half"
          @click="changePage(-1)"
        ></div>
        <div
          id="right-control"
          class="column is-half"
          @click="changePage(1)"
        ></div>
      </div>
    </div>
  </div>
</template>

<script>
import screenfull from "screenfull";
import ComicPage from "@/models/comicPage";
import ImageBuffer from "@/models/imageBuffer";
import Progression from "@/models/progressionService";

export default {
  data() {
    return {
      currentPage: null,
      buffer: [],
    };
  },
  methods: {
    changePage(direction) {
      if (direction > 0) {
        this.buffer.foward();
      } else {
        this.buffer.backward();
      }
      this.$router.replace(this.buffer.current().readerPath());
      this.updateProgression();
    },
    updateProgression() {
      Progression.setProgression(
        this.buffer.current().comicId,
        this.buffer.current().chapterId,
        this.buffer.current().pageNumber
      );
    },
    initPage() {
      this.currentPage = new ComicPage(
        this.$route.params.id,
        this.$route.params.chapterId,
        Number.parseInt(this.$route.params.page)
      );
      this.buffer = new ImageBuffer(this.currentPage);
      this.updateProgression();
    },
    toggleFullscreen() {
      screenfull.toggle(this.$el);
    },
  },
  created() {
    this.initPage();
  },
};
</script>

<style>
#image-container {
  height: 100vh;
  width: 100%;
  background-color: black;
  margin: 0;
}

.page {
  object-fit: scale-down;
  width: 100%;
  height: 100%;
}

#reader {
  display: grid;
}

#image-container,
#overlay-control {
  grid-area: 1 / 1;
}

#overlay-control {
  height: 100vh;
}

#top-control {
  height: 10em;
  /*border: 1px red solid;*/
}

#right-control {
  /*border: 1px greenyellow solid;*/
}

#left-control {
  /*border: 1px blue solid;*/
}

#left-right-control-container {
  height: calc(100vh - 10em);
}

.columns {
  margin: 0 !important;
}
</style>
