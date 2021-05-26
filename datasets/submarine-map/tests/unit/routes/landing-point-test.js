import { module, test } from 'qunit';
import { setupTest } from 'ember-qunit';

module('Unit | Route | landing-point', function(hooks) {
  setupTest(hooks);

  test('it exists', function(assert) {
    let route = this.owner.lookup('route:landing-point');
    assert.ok(route);
  });
});
