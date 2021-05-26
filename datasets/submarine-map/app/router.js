import EmberRouter from '@ember/routing/router';
import config from './config/environment';

const Router = EmberRouter.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route("submarine-cable", { path: "/submarine-cable/:slug" });
  this.route("landing-point", { path: "/landing-point/:slug" });
  this.route("country", { path: "/country/:slug" });
  this.route("ready-for-service", { path: "/ready-for-service/:slug" });
});

export default Router;
