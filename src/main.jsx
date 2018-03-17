import {h} from './link'
import {dateOption, selectionOption, suggestions} from './containers'

export default () =>
<div>
  <div class="options">
    <date-option name="time" />
    <selection-option name="start" select="station" />
    <selection-option name="destination" select="station" />
  </div>
  <suggestions />
</div>
