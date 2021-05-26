/* global google */
import Component from '@ember/component';
import { getOwner } from '@ember/application';
import $ from 'jquery';

export default Component.extend({
  mouseEnter() {
    let application = getOwner(this).application;
    let anchor = $(this.element).find('a')[0]
    application.map.infoBox.setPosition(new google.maps.LatLng($(anchor).attr('name').split(",")[0], $(anchor).attr('name').split(",")[1]))
    application.map.infoBox.setContent(`<div class="infoBoxContent"><div class="infoBoxPointer"></div>${$(anchor)[0].innerHTML}</div>`)
    application.map.infoBox.open(application.map.gmap)
  },
  mouseLeave() {
    let application = getOwner(this).application;
    application.map.infoBox.close()
  }
});
