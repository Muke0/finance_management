import { createApp } from "vue";
import "./style.css";
import App from "./App.vue";
import ElementPlus from "element-plus";
import "element-plus/dist/index.css";
import router from "./router/router.js";
import * as ElementPlusIconsVue from "@element-plus/icons-vue";
import axios from "axios";

axios.defaults.baseURL = "http://43.142.182.70:9998";

const app = createApp(App);

app.use(ElementPlus);
app.use(router);
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component);
}
app.mount("#app");

