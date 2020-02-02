<template>
  <div class="field" id="preview_user_image">
    <label for="user_image">プロフィール画像（任意）</label>
    <label class="fileup-btn" for="user_image" :style="{ backgroundImage: 'url(' + data.image + ')' }"></label>
    <input
      class="hidden"
      type="file"
      name="user[image]"
      id="user_image"
      accept="image/*"
      ref="file"
      @change="setImage"
    />
  </div>
</template>

<script>
export default {
  data() {
    return {
      data: {
        image: '/assets/icon_plus.svg',
        name: ''
      }
    };
  },
  methods: {
    setImage(e) {
      const files = this.$refs.file;
      const fileImg = files.files[0];
      if (fileImg.type.startsWith('image/')) {
        this.data.image = window.URL.createObjectURL(fileImg);
        this.data.name = fileImg.name;
        this.data.type = fileImg.type;
      }
    }
  }
};
</script>
