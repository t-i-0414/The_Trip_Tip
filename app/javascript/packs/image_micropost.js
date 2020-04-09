import Vue from 'vue/dist/vue.esm';
import App from '../image_micropost.vue';

Vue.config.productionTip = false;

$(() => {
  new Vue({
    render: h => h(App)
  }).$mount('#preview_micropost_image')
});
