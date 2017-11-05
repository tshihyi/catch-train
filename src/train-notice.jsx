import {h} from './link'

export default ({departure, arrival}) =>
<div class="notice">
  <div>
    <div class="time">
      {departure}
    </div>
    <div >
      當前車站
    </div>
  </div>
  <div>
    <i class="material-icons">arrow_forward</i>
  </div>
  <div>
    <div class="time">
      {arrival}
    </div>
    <div>
      新左營
    </div>
  </div>
</div>
