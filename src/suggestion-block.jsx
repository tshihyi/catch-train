import {h} from './link'

export default ({items}) =>
<div class="suggestions">
  {items.map(({train, departure, arrival}) =>
    <div>
      <div>{train}</div>
      <div>{departure}</div>
      <div>{arrival}</div>
    </div>
  )}
</div>
