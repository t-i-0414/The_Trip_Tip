import Vue from 'vue/dist/vue.esm';
import App from '../image_user-profile.vue';

Vue.config.productionTip = false;

$(() => {
  new Vue({
    render: h => h(App),
  }).$mount('#preview_user_image')
});
