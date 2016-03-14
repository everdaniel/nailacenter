// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().parent().before(content.replace(regexp, new_id));
  setup_autocomplete($(link).parent().parent().parent().children("tr.fields").last().find('input.product_autocomplete'));
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function setup_autocomplete(field) {
  field.autocomplete({
    minLength: 2,
    source: field.data('autocomplete-source'),
    focus: function(event, ui) {
      field.parent().parent().children().first().find("input").val(ui.item.id);
      return false;
    },
    select: function(event, ui) {
      field.parent().parent().children().first().find("input").val(ui.item.id).attr('readonly', true);
      field.parent().parent().children().find("input.product_autocomplete").val(ui.item.short_name).attr('readonly', true);
      field.parent().parent().children().find("input.product_quantity").focus();
      return false;
    }
  })
  .data("ui-autocomplete")._renderItem = function(ul, item) {
    return $( "<li>" )
        .append( "<a>" + item.id + " | " + item.short_name + "</a>" )
        .appendTo( ul );
  }
}
/*
jQuery ->
  if ($('input.product_autocomplete').size > 0)
    $('input.product_autocomplete').autocomplete
      source: $('input.product_autocomplete').data('autocomplete-source')
    .data('ui-autocomplete')._renderItem = (ul, item) ->
      console.log(ul)
      console.log(item)
      $( "<li>" )
          .append( "<a>" + item.id + "<br>" + item.short_name + "</a>" )
          .appendTo( ul );
          */
