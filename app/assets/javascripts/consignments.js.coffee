# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  if ($('input.product_autocomplete').size() > 0)
    $('input.product_autocomplete').each ->
      setup_autocomplete($(this));
      return
    return