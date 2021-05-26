import Component from '@ember/component';
import { getOwner } from '@ember/application';
import $ from 'jquery';

export default Component.extend({
  didInsertElement(){
    this._super(...arguments);
    let application = getOwner(this).application;
    application.swapCompany();
  }
});
