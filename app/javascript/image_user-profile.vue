<template>
  <div id="preview_user_image">
    <div class="field">
      <label for="user_image-before">プロフィール画像（任意）</label>
      <label
        class="fileup-btn"
        for="user_image-before"
        :style="{ backgroundImage: 'url(' + cropImg + ')' }"
      ></label>
      <input
        class="hidden"
        id="user_image-before"
        ref="input"
        type="file"
        name
        accept="image/*"
        @change="setImage"
      />
      <div v-if="imgSrc != ''" :key="imgSrc" class="view-trimming">
        <vue-cropper
          ref="cropper"
          :guides="true"
          :view-mode="2"
          drag-mode="crop"
          :auto-crop-area="0.5"
          :min-container-width="250"
          :min-container-height="250"
          :background="true"
          :rotatable="true"
          :src="imgSrc"
          :img-style="{ width: '400px', height: '400px' }"
          :aspect-ratio="yoko / tate"
        ></vue-cropper>
        <div class="cropper_actions">
          <div class="trimming" @click="cropImage" v-if="imgSrc != ''">画像を切り抜く</div>
          <div class="trimming" @click="rotate(-90)" v-if="imgSrc != ''">画像を回転させる</div>
          <div class="trimming" @click="removeImage" v-if="imgSrc != ''">画像選択を解除する</div>
          <a
            class="downloader"
            v-if="cropImg != '/assets/icon_plus.svg'"
            :href="cropImg"
            :download="filename"
          >切り抜いた画像を保存する（任意）</a>
        </div>
        <input class="hidden" id="user_image" name="user[image]" type="text" :value="cropImg" />
      </div>
    </div>
  </div>
</template>
<script>
import Vue from 'vue/dist/vue.esm';
import VueCropper from 'vue-cropperjs';
import 'cropperjs/dist/cropper.css';

export default {
  components: {
    VueCropper
  },
  data() {
    return {
      yoko: 1,
      tate: 1,
      imgSrc: '',
      cropImg: '/assets/icon_plus.svg',
      filename: '',
      resizedBlob: ''
    };
  },
  methods: {
    setImage(e) {
      let count = e.target.files.length - 1;
      const file = e.target.files[count];
      this.filename = file.name;
      if (!file.type.includes('image/')) {
        alert('画像ファイルを選択してください。');
        return;
      }
      if (typeof FileReader === 'function') {
        const reader = new FileReader();
        reader.onload = event => {
          this.imgSrc = event.target.result;
        };
        reader.readAsDataURL(file);
      } else {
        alert('この画像ファイルには対応しておりません。');
      }
    },

    cropImage() {
      this.cropImg = this.$refs.cropper.getCroppedCanvas().toDataURL('image/jpeg');
      this.resizedBlob = this.base64ToBlob(this.cropImg);
    },

    rotate(deg) {
      this.$refs.cropper.rotate(deg);
    },

    removeImage() {
      this.imgSrc = '';
      this.cropImg = '/assets/icon_plus.svg';
      this.filename = '';
      this.resizedBlob = '';
    },

    base64ToBlob(base64) {
      const bin = atob(base64.replace(/^.*,/, ''));
      const buffer = new Uint8Array(bin.length);
      for (let i = 0; i < bin.length; i++) {
        buffer[i] = bin.charCodeAt(i);
      }
      return new Blob([buffer.buffer], {
        type: 'image/jpeg'
      });
    }
  }
};
$(document).ready(function() {
  $('#user_image').val(null);
});
</script>
