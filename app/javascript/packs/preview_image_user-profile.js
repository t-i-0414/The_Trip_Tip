import Vue from 'vue/dist/vue.esm';
import App from '../preview_image_user-profile.vue';

$(() => {
  const app = new Vue({
    render: h => h(App)
  }).$mount('#preview_user_image')
});
