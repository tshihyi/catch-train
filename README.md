# catch-train

個人化火車即時班次

Work in progress

## Facts

[Station name list](https://gistcdn.githack.com/dk00/66edd93eb6b737fb2b8acc7f987ff25d/raw/fdfc496fb22e36721ba18d2ed39f1e2b9feb57aa/tra-stations.json)

[Timetable data source](https://data.gov.tw/dataset/6138)

Number of stations: 259
Number of trains: 921
Number of timetable entries per day: 18787
Average stops of one train: 20.4
Default size limit of offline browser storage: 10 MB

## Data structure

Train schedule data is represented by list of departure time, in the following format:

`{date, station, train, departure}`

```
date: 2018-02-08
station: 1142
train: 1234
departure: 22:21
```

Every entry costs 74 bytes, so it takes 1358 KB / day to fully store timetable data uncompressed.

```
2018-02-08:
  1142:
    1234: 13:43
```

It takes about 16 bytes per entries when stored in nested format, that is 294 KB.

## Structures

### Source data format

An array contains list of trains, and timetable for each train.

A timetable (for a train) is an array contains entries of station and deprature time.

```yml
TrainInfos:
  0:
    Train: 2134
    Type: ASDF
    TimeInfos:
      0:
        Station: 1025
        ArrTime: 07:58:00
        DepTime: 08:00:00
        Route: ''
        Order: 1
```

### DB data format

A collection of timetable entries and a collection of date groups.

Number of (distinct) timetable entries: 19660
Number of date groups: 27
Data size of group collection: 703

```yml
timetableEntries:
  - train: 2134
    station: 1025
    departure: 08:00
    group: 0

dateGroups:
  0309: [0]
```

## Update timetable data

Goals:

- Offline usage. 10 MB browser storage size limit for all timetable entries.
- Reduce amount of data transferred for updating
- Avoid changing group id when updating

### Processing source data

- Get date list of all distinct timetable entries
- Make each date list combination a group, and add a group id to all timetable entries

### Syncing to clients

- Every entry have update timestamp, so that clients can get only updated entries.
