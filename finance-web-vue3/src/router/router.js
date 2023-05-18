import { createRouter, createWebHashHistory } from "vue-router";

import index from "../views/index.vue";

const routes = [
  { path: "/", component: index },
  { path: "/login", component: () => import("../views/login.vue") },
  { path: "/register", component: () => import("../views/register.vue") },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});
// 路由守卫， 检查是否登录
router.beforeEach((to, from, next) => {
  console.log(to, from);
  if (to.path === "/login" || to.path === "/register") {
    next();
  } else {
    const token = localStorage.getItem("token");
    if (token) {
      next();
    } else {
      next("/login");
    }
  }
});

export default router;
