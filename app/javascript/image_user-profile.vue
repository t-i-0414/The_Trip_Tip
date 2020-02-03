<template>
  <div class="field" id="preview_user_image">
    <label for="user_image-before">プロフィール画像（任意）</label>
    <label class="fileup-btn" for="user_image-before" :style="{ backgroundImage: 'url(' + cropImg + ')' }"></label>
    <input
      id="user_image-before"
      ref="input"
      type="file"
      name=""
      accept="image/*"
      @change="setImage"
    />
    <input
      id="user_image"
      ref="input"
      type="file"
      name="user[image]"
      accept="image/*"
    />

    <div
      v-if="imgSrc != ''"
      style="width: 200px; height:200px; border: 1px solid gray; display: inline-block;"
    >
      <vue-cropper
        ref="cropper"
        :guides="true"
        :view-mode="2"
        drag-mode="crop"
        :auto-crop-area="0.5"
        :min-container-width="200"
        :min-container-height="200"
        :background="true"
        :rotatable="false"
        :src="imgSrc"
        :img-style="{ 'width': '200px', 'height': '200px' }"
        :aspect-ratio="yoko / tate"
      ></vue-cropper>

      <button @click="cropImage upload" v-if="imgSrc != ''">トリミングする</button>
    </div>
    
    <!--<div v-if="cropImg != '/assets/icon_plus.svg'">-->
    <!--  <img-->
    <!--    :src="cropImg"-->
    <!--    style="width: yoko; height: tate; border: 1px solid gray;"-->
    <!--    alt="Cropped Image"-->
    <!--  >-->
    <!--  <p>-->
    <!--    <a :href="cropImg" :download="filename">画像を保存</a>-->
    <!--  </p>-->
    <!--</div>-->
  </div>
</template>

<script>
import VueCropper from "vue-cropperjs";
import "cropperjs/dist/cropper.css";
export default {
  components: {
    VueCropper
  },
  data() {
    return {
      yoko: 1,
      tate: 1,
      imgSrc: "",
      cropImg: '/assets/icon_plus.svg',
      filename: ""
    };
  },
  methods: {
    setImage(e) {
      e.preventDefault();
      const file = e.target.files[0];
      console.log(file);
      this.filename = file.name;
      if (!file.type.includes("image/")) {
        alert("Please select an image file");
        return;
      }
      if (typeof FileReader === "function") {
        const reader = new FileReader();
        reader.onload = event => {
          this.imgSrc = event.target.result;
          // this.$refs.cropper('replace', event.target.result);
        };
        reader.readAsDataURL(file);
      } else {
        alert("Sorry, FileReader API not supported");
      }
    },
    
    cropImage() {
      this.cropImg = this.$refs.cropper.getCroppedCanvas().toDataURL();
    },
    
    //ここから　http://tech.aainc.co.jp/archives/10714
    upload() {
      // FormData を利用して File を POST する
      let formData = new FormData();
      formData.append('yourFileKey', this.uploadFile);
      let config = {
          headers: {
              'content-type': 'multipart/form-data'
          }
      };
      axios
          .post('yourUploadUrl', formData, config)
          .then(function(response) {
              // response 処理
          })
          .catch(function(error) {
              // error 処理
          })
    }
  }
};
</script>
