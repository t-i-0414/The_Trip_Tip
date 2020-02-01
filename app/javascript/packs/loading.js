import Vue from 'vue/dist/vue.esm';

$(() => {
  new Vue({
    el: '#contents-app',
    mounted() {
      this.$nextTick(function () {
        $('#loading').fadeOut();
      });
    }
  });
});
