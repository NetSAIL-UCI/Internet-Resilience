`window.SubmarineCable = {}`

class SubmarineCable.Map
  @cablesGeoJSON: "/api/v2/cable/cable-geo.json"
  @landingsGeoJSON: "/api/v2/landing-point/landing-point-geo.json"

  @mapStyles: [
    {"featureType": "landscape","stylers": [{ "visibility": "on" },{ "color": "#d9d9d9" }]},
    {"featureType": "poi","stylers": [{ "visibility": "off" }]},
    {"featureType": "road","stylers": [{ "visibility": "off" }]},
    {"featureType": "transit","stylers": [{ "visibility": "off" }]},
    {"featureType": "administrative.locality","stylers": [{ "visibility": "off" }]},
    {"featureType": "administrative.neighborhood","stylers": [{ "visibility": "off" }]},
    {"featureType": "administrative.land_parcel","stylers": [{ "visibility": "off" }]},
    {"featureType": "administrative.country","elementType": "labels.text.fill","stylers": [{ "color": "#000000" },{ "visibility": "on" }]},
    {"featureType": "administrative.province","stylers": [{ "visibility": "off" }]},
    {"featureType": "water","elementType": "geometry.fill","stylers": [{ "color": "#ffffff" },{ "visibility": "on" }]},
    {"elementType": "labels.text.fill","stylers": [{ "color": "#808080" }]}
  ];

  landingIcon: () ->
    { url: '/assets/images/marker.png', size: new google.maps.Size(10, 10), anchor: new google.maps.Point(5, 5) }

  showCables: () ->
    @cables = new google.maps.Data({map:@gmap})
    @cables.loadGeoJson(SubmarineCable.Map.cablesGeoJSON)
    @cables.setStyle (feature) =>
      return ({strokeColor: "##{feature.getProperty("color")}", strokeWeight: 2})

  showLandingPoints: () ->
    @landings = new google.maps.Data({map:@gmap})
    @landings.loadGeoJson(SubmarineCable.Map.landingsGeoJSON)
    @landings.setStyle({icon: @landingIcon()});

  selectCable: (id, desc, is_map_clicked = false) ->
    @infoBox.close()

    @cables.setStyle (feature) =>
      if feature.getProperty("slug") is id
        return ({strokeColor: "#a81120", strokeOpacity: 1})
      else
        return ({strokeColor: "##{feature.getProperty("color")}", strokeOpacity: 0.1})

    @landings.setStyle (feature) =>
      if feature.getProperty("id") in (d.landing_point_id for d in desc)
        return ({icon: @landingIcon()})
      else
        return ({icon: @landingIcon(), visible:false})

    @boundMap(desc)

  selectCountry: (cables, landing_points, latlons) ->
    @infoBox.close()

    @cables.setStyle (feature) =>
      if feature.getProperty("slug") in (d.id for d in cables)
        return ({strokeColor: "##{feature.getProperty("color")}", strokeOpacity: 1})
      else
        return ({strokeColor: "##{feature.getProperty("color")}", strokeOpacity: 0.1})

    @landings.setStyle (feature) =>
      if feature.getProperty("id") in (d.landing_point_id for d in landing_points)
        return ({icon: @landingIcon()})
      else
        return ({icon: @landingIcon(), visible:false})

    @boundMap(latlons)

  selectRfs: (data) ->
    @infoBox.close()

    @cables.setStyle (feature) =>
      if feature.getProperty("slug") in (d.id for d in data.cables)
        return ({strokeColor: "##{feature.getProperty("color")}", strokeOpacity: 1})
      else
        return ({strokeColor: "##{feature.getProperty("color")}", strokeOpacity: 0.1})
    #
    @landings.setStyle (feature) =>
      if feature.getProperty("id") in (d.landing_point_id for d in data.landing_points)
        return ({icon: @landingIcon()})
      else
        return ({icon: @landingIcon(), visible:false})

  boundMap: (desc) ->
    bounds = new google.maps.LatLngBounds()
    for value in desc
      bounds.extend new google.maps.LatLng value.latlon.split(',')[0], value.latlon.split(',')[1]
    @gmap.fitBounds bounds
    if @gmap.getZoom() > 5
      @gmap.setZoom @gmap.getZoom() - 2

  selectLandingPoint: (name, latLng) ->
    @cables.setStyle (feature) =>
      return ({strokeColor: "##{feature.getProperty("color")}", strokeOpacity: 1})
    @landings.setStyle (feature) =>
      return ({icon: @landingIcon()})
    @infoBox.close()
    @gmap.panTo latLng
    @infoBox.setContent "<div class=\"infoBoxContent\"><div class=\"infoBoxPointer\"></div>#{name}</div>"
    @infoBox.setPosition latLng
    @infoBox.open @gmap

  resetMap: () ->
    @cables.setStyle (feature) =>
      return ({strokeColor: "##{feature.getProperty("color")}", strokeOpacity: 1})
    @landings.setStyle (feature) =>
      return ({icon: @landingIcon()})
    @infoBox.close()

  resetBounds: () ->
    @gmap.setZoom 2
    @gmap.setCenter new google.maps.LatLng(30.0,-30.0)

  setEvents: () ->
    google.maps.event.addListener @gmap, 'click', (event) =>
      jQuery(location).attr('href',"#/")
    @cables.addListener 'click', (event) =>
      jQuery(location).attr('href',"#/submarine-cable/#{event.feature.getProperty('slug')}")
    @landings.addListener 'click', (event) =>
      jQuery(location).attr('href',"#/landing-point/#{event.feature.getProperty('slug')}")

  isMobile: () ->
    try
      window.matchMedia("only screen and (max-width:736px)").matches
    catch error
      false

  analytics: (category, action, label) ->
    # _gaq.push(['_trackEvent', category, action, label]) if _gaq

  constructor: (@element, @config) ->
    @creation_time = @config.creation_time
    @gmap = new google.maps.Map document.getElementById(@element), {
      zoom: if @isMobile() then 1 else 3,
      maxZoom: 8,
      minZoom: 2,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      styles: SubmarineCable.Map.mapStyles,
      center: new google.maps.LatLng(30.0,-30.0),
      streetViewControl: false,
      mapTypeControl: false,
      zoomControlOptions:
        position: google.maps.ControlPosition.TOP_LEFT
      disableDefaultUI: if @isMobile() then true else false
    }
    @infoBox = new InfoBox({closeBoxURL:"",alignBottom:true,pixelOffset:new google.maps.Size(-60,-15)})
    @showCables()
    @showLandingPoints()
    @setEvents()
    return this

