import {h} from './link'

export default ({items}) =>
<div class="suggestions">
  {items.map(({station, departure, arrival}) =>
    <div>
      <div>{station}</div>
      <div>{departure}</div>
      <div>{arrival}</div>
    </div>
  )}
</div>
