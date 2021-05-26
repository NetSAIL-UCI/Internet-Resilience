import Route from '@ember/routing/route';
import { getOwner } from '@ember/application';
import $ from 'jquery';

export default Route.extend({
  setupController(controller){
    this._super(...arguments);
    let application = getOwner(this).application;
    window.scrollTo(0,0);
    $.getJSON(`${application.apiPath}/cable/all.json`, function(data){
      if(application.map){
        application.map.resetMap();
      }
      controller.set("model",  data);
    });

  }


});
