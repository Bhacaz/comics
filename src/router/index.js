import { createRouter, createWebHashHistory } from "vue-router";
import Home from "../views/Home.vue";
import Comic from "../views/Comic.vue";

const routes = [
  {
    path: "/",
    component: Home,
  },
  {
    path: "/comic/:id",
    component: Comic,
  },
  {
    path: "/reader/:id/:chapterId/:page",
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/Reader.vue"),
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
