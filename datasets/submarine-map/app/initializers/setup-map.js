/* global SubmarineCable */
import $ from 'jquery';

export function initialize(application) {

  application.set('apiPath', "api/v2");
  application.set('map', null);
  application.set('search', null);
  application.set('getSlug', function(model){
    let slug = null;
    if(!model.slug){
      slug = model;
    }else{
      slug = model.slug;
    }
    return slug;
  });

  application.set('swapCompany', function(currentCompany = Math.round(Math.random())){
    let companyNames = ['Huawei Marine', 'Equinix'];
    companyNames.forEach(function(d, i) {
      let target = $(`.${companyNames[i].toLowerCase().replace(" ","-")}-logo`);
      (i == currentCompany) ? target.fadeIn() : target.fadeOut();
    });
    $("span.company, span.company-portrait").text(`Sponsored in part by ${companyNames[currentCompany]}`);
    setTimeout(function(){ application.swapCompany(currentCompany ? 0 : 1); }, 5000);
  },)

  application.deferReadiness();
  $.getJSON(`/${application.apiPath}/config.json`, function(data) {
    application.set('mapConfig', data);
    application.set('search', new SubmarineCable.Search());
    application.advanceReadiness();
  });

}

export default {
  initialize
};
