import Route from '@ember/routing/route';
import { getOwner } from '@ember/application';
import $ from 'jquery';

export default Route.extend({
  setupController(controller, model){
    this._super(...arguments);
    window.scrollTo(0,0);
    let application = getOwner(this).application;
    $.getJSON(`${application.apiPath}/country/${application.getSlug(model)}.json`, function(data){
      controller.set("model",  data);
      if(application.map){
        application.map.selectCountry(data.cables, data.landing_points, data.latlon);
      }
    });
  }
});
