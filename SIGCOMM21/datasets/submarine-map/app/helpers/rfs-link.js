import { helper } from '@ember/component/helper';
import { htmlSafe } from '@ember/string';

export function rfsLink(params) {
  let rfs = params[0];
  if(rfs == "n.a.") {
    return rfs
  } else {
    return new htmlSafe(`<a href="/#/ready-for-service/${rfs.replace(/(Q|H)[1-4]{1}/,"").match(/\d/g).join("")}">${rfs}</a>`);
  }
}

export default helper(rfsLink);
