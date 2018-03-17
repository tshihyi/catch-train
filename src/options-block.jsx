import {h} from './link'
import {selectionOption, dateOption} from './containers'

export default () =>
<div class="options">
  <date-option name="time" />
  <selection-option name="target" select="target-type" />
  <selection-option name="start" select="station" />
  <selection-option name="destination" select="station" />
</div>
