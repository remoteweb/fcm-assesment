# Introduction
The implementation parses raw input of the following format,

```
RESERVATION
SEGMENT: Hotel BCN 2020-01-05 -> 2020-01-10

RESERVATION
SEGMENT: Flight SVQ 2020-01-05 20:40 -> BCN 22:10
SEGMENT: Flight BCN 2020-01-10 10:30 -> SVQ 11:50

RESERVATION
SEGMENT: Train SVQ 2020-02-15 09:30 -> MAD 11:00
SEGMENT: Train MAD 2020-02-17 17:00 -> SVQ 19:30

RESERVATION
SEGMENT: Hotel MAD 2020-02-15 -> 2020-02-17
```

and print them as

```
TRIP to BCN
Flight from SVQ to BCN at 2020-01-05 20:40 to 22:10
Hotel at BCN on 2020-01-05 to 2020-01-10
Flight from BCN to SVQ at 2020-01-10 10:30 to 11:50

TRIP to MAD
Train from SVQ to MAD at 2020-02-15 09:30 to 11:00
Hotel at MAD on 2020-02-15 to 2020-02-17
Train from MAD to SVQ at 2020-02-17 17:00 to 19:30
```

```
git clone git@github.com:remoteweb/fcm-assesment.git
cd fcm-assessment
rake import
rake print
```

Model Diagram


![Model Diagram](https://github.com/remoteweb/fcm-assessment/blob/main/public/other/model_diagram.png?raw=true)


## Running the test locally

Requires

- Ruby 3.1.1
- Rails 7.0.2.3
- Postgres 14.2

```
git clone git@github.com:remoteweb/fcm-assessment.git
cd fcm-assessment
bundle install
rails db:create
rails db:migrate
rake import
rake print
```