import { module, test } from 'qunit';
import { setupTest } from 'ember-qunit';

module('Unit | Route | ready-for-service', function(hooks) {
  setupTest(hooks);

  test('it exists', function(assert) {
    let route = this.owner.lookup('route:ready-for-service');
    assert.ok(route);
  });
});
