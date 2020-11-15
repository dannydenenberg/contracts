$(function() {
  $("#share-button").on("click", function(e) {
    e.preventDefault();

    $(".qr-svg").toggle(); // show the contact form

    return false;
  })
})