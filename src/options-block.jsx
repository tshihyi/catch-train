import {h} from './link'

const selection = ({options, value}) =>
<select>
  {Object.entries(options).map(([key, label]) =>
    <option value={key} selected={value == key} label={label}>{label}</option>
  )}
</select>

const targetTypes = {
  start: '出發',
  destination: '抵達'
}

const localTime = date => {
  const d = new Date(date)
  d.setMinutes(d.getMinutes() - 2*d.getTimezoneOffset())
  console.log(date, d);
  return d.toJSON().slice(0, 16)
}
const UTCTime = onChange => ({target: {value}}) =>
onChange({target: {value: new Date(value).toJSON()}})

const dateInput = ({value, onChange, ...attrs}) =>
<input type="datetime-local"
  value={localTime(value)} onChange={UTCTime(onChange)} {...attrs} />

export default ({time, type, location, stations}) =>
<div class="options">
  <date-input {...time} />
  <selection options={targetTypes} {...type} />
  <selection options={stations} {...location}/>
</div>
