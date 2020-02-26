$(() => {
  userDrawer = $('.user_drawer').length;
  console.log(userDrawer);
  if (userDrawer == 0) {
    $('#userDetailOpen').css({
      'display': 'none'
    });
  }
});
