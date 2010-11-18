$(function() {
  extLinksInNewTab();
});

// Wait until everything is loaded before continuing
$(window).load(function() {
  if(window.location.pathname == '/') { checkForUpdates(); }
});

// See if there's anything new
function checkForUpdates() {
  $('body').append('<div id="status" style="display: none;">Fetching latest updates...</div>');
  $('#status').fadeIn(500);
  $.getScript('/latest_updates.js');
}

// Load external links in new tab/window
function extLinksInNewTab() {
  $('a[href^="http"]').attr('target', '_blank');
}

