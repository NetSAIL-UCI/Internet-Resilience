/* global SubmarineCable */
import Component from '@ember/component';
import { getOwner } from '@ember/application';
import $ from 'jquery';

export default Component.extend({
  classNames: ['map-container'],
  didInsertElement(){
    this._super(...arguments);
    let application = getOwner(this).application;
    $('body').find('.ember-view').first().addClass('map-container');
    if(!application.map && application.mapConfig){
      application.set('map', new SubmarineCable.Map('map', application.mapConfig));
    }
  }
});