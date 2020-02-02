$(window).on('load', () => {
  let count = 393;
  setInterval(() => {
    $(".bg").css(
      "background", "linear-gradient(" + (count % 360) + "deg, #8fd3f4 0%, #8ed5ef 24%, #8cdce3 48%, #88e8ce 73%, #84f8b1 99%, #84fab0 100%)"
    );
    count++;
  }, 30);
});
