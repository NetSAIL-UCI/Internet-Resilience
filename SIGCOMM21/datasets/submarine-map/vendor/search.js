// Generated by CoffeeScript 2.3.2
(function() {
  SubmarineCable.Search = (function() {
    class Search {
      // analytics: (category, action, label) ->
      //   _gaq.push(['_trackEvent', category, action, label]) if _gaq
      constructor() {
        jQuery.getJSON(SubmarineCable.Search.searchJsonPath, (data) => {
          return jQuery("#search").autocomplete({
            position: {
              my: "right top+12",
              at: "right bottom"
            },
            source: data,
            open: function(event, ui) {
              jQuery(".ui-menu-item a:contains(Connected)").addClass('country');
              return jQuery(".ui-menu-item a:contains(Ready)").addClass('rfs');
            },
            close: function(event, ui) {
              jQuery("#search").val("Search");
              return jQuery("#search").blur();
            },
            select: function(event, ui) {
              return window.location.href = ui.item.url;
            }
          });
        });
        // Search Input Focus/Blur
        jQuery("#search").val("Search").focus(function() {
          jQuery(this).addClass("focus");
          jQuery("#nav").addClass("focus");
          if (jQuery(this).val() === "Search") {
            jQuery(this).val("");
          }
          if (window.matchMedia("only screen and (max-width:736px) and (orientation : portrait)").matches) {
            console.log("mobile search");
            return window.scrollTo(0, jQuery("#nav").offset().top);
          }
        }).blur(function() {
          jQuery(this).removeClass("focus").val("Search");
          return jQuery("#nav").removeClass("focus");
        });
      }

    };

    Search.searchJsonPath = "/api/v2/search.json";

    return Search;

  }).call(this);

}).call(this);