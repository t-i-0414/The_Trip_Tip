$(() => {
  let userImage = document.getElementById("#user_image");
 
 console.log(userImage);
 
  // 選択された画像を取得し表示
  $(document).on("change", userImage, ( e => {
    let file = e.target.files[0];
    let reader = new FileReader();
    let preview = $("#preview_user_image");
 
    reader.onload = ( file => {
      return  ( e => {
        preview.empty();
        preview.append($("<img>").attr({
          src: e.target.result,
          width: "100%",
          class: "preview",
          title: file.name
        }));
      });
    })(file);
    reader.readAsDataURL(file);
  }));
})();


