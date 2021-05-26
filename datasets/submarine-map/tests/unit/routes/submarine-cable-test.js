import { module, test } from 'qunit';
import { setupTest } from 'ember-qunit';

module('Unit | Route | submarine-cable', function(hooks) {
  setupTest(hooks);

  test('it exists', function(assert) {
    let route = this.owner.lookup('route:submarine-cable');
    assert.ok(route);
  });
});
