
# Comprehensive Airspace Simulation

## Table of Contents

- [Comprehensive Airspace Simulation](#comprehensive-airspace-simulation)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Goals](#goals)
  - [Scenarios](#scenarios)
    - [Extrapolating real world scenarios from TCL demos](#extrapolating-real-world-scenarios-from-tcl-demos)
    - [Broadcast Remote ID projections for the airspace](#broadcast-remote-id-projections-for-the-airspace)
    - [Flights and Broadcast Remote ID Bandwidth](#flights-and-broadcast-remote-id-bandwidth)
    - [Broadcast Remote ID Sensor Network](#broadcast-remote-id-sensor-network)
    - [Broadcast Remote ID sensors for Major highway corridoors](#broadcast-remote-id-sensors-for-major-highway-corridoors)
      - [Tracking error and packet loss](#tracking-error-and-packet-loss)
    - [Network Remote ID projections](#network-remote-id-projections)
  - [Acknowledgements](#acknowledgements)
  - [Revision History](#revision-history)

## Introduction

The aim of this document is to develop operating parameters and performance envelope for software systems in the context of UTM / U-Space. The UTM eco-system software that includes for e.g. [DSS software](https://github.com/interuss/dss), [registry](https://github.com/openskies-sh/aircraftregistry), [identity and authentication](https://github.com/openskies-sh/flight_passport) are essentially a series of complex interconnected technologies and processes that need comprehensive testing at different levels of the stack.

## Goals

There are two major goals of this document, to develop a assessment of the security standards, hardware tests and develop data on the operational requirements for an airspace. It hopes to address the questions for policy makers around design of airspace, developing performance of de-confliction algorithms etc. At a broader level, the goal of this document is to develop an understanding of the resilince / brittleness of the airspace as it gets more active. Finally, this document hopes to develop a comprehensive software suite to test for these scenarios.

## Scenarios

To build a comprehensive testing and load simulation, we utilize the TCL program to develop scenarios. NASA has developed a series of tests under the Technology Capabiltiy Level (TCL) program to demonstrate and operationalize key enabling technologies for UTM in an increasing order of complexity. NASA has provided detailed reports about these tests and they are available on the [NASA UTM website](https://utm.arc.nasa.gov/documents.shtml). These demonstrators increase in complexity of missions and diverse stakeholders, the most important and relevant scenarios as demosntrated in the TCL tests is in TCL 3 and 4. TCL 4 specifically focuses on high-density urban operations, the most complicated scenario for a registry and we will focus on this.

### Extrapolating real world scenarios from TCL demos

The TCL tests are just a demonstration of core technical capability but can be a useful basis to extrapolate to understand potential real-world flight densities. For more information about TCL 4 reports, please reveiew the [results and analysis](https://utm.arc.nasa.gov/docs/2020-Rios_TM_220462-USS-Net-Perf.pdf) PDF. The most relevant Measures of Performance (MOP) for this document is UTM-MOP-16:

- _"Successful High Density Operations" which is define as the following “measures the number of (live and simulated) aircraft per defined 0.2nmi​2​ of UTM operations."_
- _"For this analysis, the minimum success criteria was more precisely defined as “ 10 aircraft (atleast 3 live operations) airborne and managed by UTM within an area of 0.2 nmi​2​."_
- _"The value of 0.2 nmi​2​ is roughlyequivalent to 720 m​2​ or a circle with radius 406m, For all calculations in this paper, a circle with 406m radius was used to calculate density."_
  
<br>From the document, below is a image of the study area that is 406m in density with > 10 flights.

TCL demonstrators are not meant to be a reflection of a real world "fully active" use. In addition to Reno, there were tests in the  Corpus Christi area. We can extrapolate this using data about Reno by making some assumptions.

| Parameter | Reno, Nevada | Corpus Christi, Texas|
| -- | :-------------: |:-------------:|
| Study Area | <img src="https://i.imgur.com/sHWaESL.jpg"> | <img src="https://i.imgur.com/xv5ZB3W.png"> |
| People in AOI | A 406 m radius circle gives a area of 517585.04 m<sup>2</sup> or 0.51758 km<sup>2</sup> area. According to [Wikipedia](https://en.wikipedia.org/wiki/Reno,_Nevada), the population density of Reno is about 820 / km<sup>2</sup> or <br><br> *425 people* in our area of interest. |  A 406 m radius circle gives a area of 517585.04 m<sup>2</sup> or 0.51758 km<sup>2</sup> area. According to [Wikipedia](https://en.wikipedia.org/wiki/Corpus_Christi,_Texas), the population density of Corpus Christi is about 710 / km<sup>2</sup> or <br><br> *366 people* in our area of interest. |
| Urgent Delivery Flights in downtown| Assume that the urgent package delivery market with the following assumptions: 5% of the people are interested in urgent delivery (22 people in the area, they order urgent delivery twice a week (22 x 2 packages x 2 days) <br><br> **88 flights / week** | Assume that the urgent package delivery market with the following assumptions: 5% of the people are interested in urgent delivery (18 people in the area), they order urgent delivery twice a week (18 x 2 packages x 2 days) <br><br> **72 flights / week** |
| Metro Area Map | <img src="https://i.imgur.com/i8Cpz0C.png" height="400"> | <img src="https://i.imgur.com/vU9Ex7J.jpg" height="400"> |
| Metro Area size | Reno City has a population of 250,998 and a area of __274.2__ km<sup>2</sup> (Source: [Wikipedia](https://en.wikipedia.org/wiki/Reno,_Nevada)). | Corpus Christi Metro Area has a population of 326,554 and a area of __1,304__ km<sup>2</sup> (Source: [Wikipedia](https://en.wikipedia.org/wiki/Corpus_Christi,_Texas))|
| Urgent delivery flights in Metro Area | For the entire Reno, NV area, we get the following: 5% of the people are interested in urgent delivery (12,550 people in the city), they order urgent delivery twice a week (12550 x 2 packages x 2 days) = 50,200 flights (back and forth). This means that every week there will be potentially <br><br>**50,200 flights per week**  | For Corpus Christi, TX area, we get the following: 5% of the people are interested in urgent delivery (16328 people in the city), they order urgent delivery twice a week (16328 x 2 packages x 2 days) = 65310 flights (back and forth). This means that every week there will be potentially <br><br>**65,310 flights per week**  |
| Hourly flights (assuming 40 hours to fly / week) | 50,200 flights and 40 hours to fly <br><br> **1255 flights / hour**  |  65,310 flights and 40 hours to fly <br><br> **1633 flights / hour**|

### Broadcast Remote ID projections for the airspace

In this section, we develop projections of broadcast Remote ID messages, the ASTM spec says that the UAS can use either Wifi or Bluetooth 4.0 or Bluetooth 5.0 to transmit the information as part of WiFi Aware for e.g. advertisement messages.

### Flights and Broadcast Remote ID Bandwidth

| | |
| ------------- |-------------|
| Average flight return time (Assuming average speed of 35 km/hr and average distance of 10 km) | __34 mins__ |
| Number of broadcast Remote ID messages per flight  | __2040__ (1 per second)  |
| Minimum Mandatory fields (Basic ID Message + Location / Vector Message) | __50 bytes__ |
| Maximum data message size (uncompressed) if all fields used e.g. Authentication System Message and Operator ID | __150 bytes__ |
| Minimum messages per return flight (35 mins @ 1 message/ sec = 2040 messages, 50 bytes / message | 2040 * 50 = **102,000 bytes** |
| Maximum messages per return flight (35 mins @ 1 message/ sec = 2040 messages, 150 bytes / message | 2040 * 150 =**306,000 bytes** |

<br>

| Parameter | Reno, Nevada | Corpus Christi, Texas|
|---| ------------- |-------------|
| Average Flight time | 34 mins. | 30 mins. |
|Flight Frequency | 1255 flights / hour | 1633 flights / hour |
|Flights in the air | 25% capacity - 313 flights / hour <br>50% capacity - 627 flights / hour <br>75% capacity - 942 flights / hour |25% capacity -  408 flights / hour <br>50% capacity - 816 flights / hour <br>75% capacity-  1224 flights / hour |

Using this we develop a flight density and bandwidth envelope as shown below throughout the entire airspace <br> 

<img src="https://i.imgur.com/TUXA4bO.jpg" width="400"><br> <img src="https://i.imgur.com/lSfiUm3.jpg" width="400">

### Broadcast Remote ID Sensor Network


Typically the range of a WiFi signal is about 125-150 ft. or 38 - 45 meters. For the sake of simplicity we assume 40 meters. A drone flying at 35 km / hour (9.7 m/s) will cover 50 meters in rougly 5.1 seconds. If we assume a mesh of WiFi receivers at 50 meters (the range of WiFi aware signal), we can estimate the number of sensors necessary to cover the entire study area.

| Parameter | Reno, Nevada | Corpus Christi, Texas|
|---| ------------- |-------------|
|Representative Map (sensors at ~50m distance, city boundaries and current roads) | <img src="https://i.imgur.com/8LiTYwn.jpg" width="350"> | <img src="https://i.imgur.com/y6ECQv3.jpg" width="350">|
| Number of sensors to cover every 50 m | **104388** | **4711** |

With almost 1255 flights / hour and almost half of them in the air at any time, at the most trafficed locations in the city (e.g. downtown) will have the most number of flights in the air. For the sake of simplicity we can assume that 3% of flights will be flying through downtown. This means that the receiver should be able to process **37 broadcast messages every second** in the Reno area.

### Broadcast Remote ID sensors for Major highway corridoors

| Parameter | Reno, Nevada | Corpus Christi, Texas|
|---| ------------- |-------------|
| Total Length of major highways | 81.78 kms | 52.27 kms |
| Theoritical number of sensors required (every 50 m) | **1635** | **1045** |
| Sensor locations | <img src="https://i.imgur.com/1wUd2sq.jpg" width="350"> | <img src="https://i.imgur.com/bVKMTuF.jpgs" width="350"> |

#### Tracking error and packet loss
Assuming 50% of total flights will go over primary roads:

| Number of flights | Bandwidth|
| ------------- |-------------|
|<img src="https://i.imgur.com/48yXeGa.jpg" width="350"> | <img src="https://i.imgur.com/11w6uyh.jpg" width="350"> |

| Parameter | |
|---| ------------- |-------------|
| Flights to be tracked / min | <img src="https://i.imgur.com/POGoakn.jpg" width="350"> |
| Flight speed | 35 km/ hour or 9.7 m /s  |
| Distance / sensors  | 10 km / 200 sensors  |
| Sensor performance | 0% packet loss  -  100% flights tracked  <br>10% - <br> 20% - <br> 30% - <br>40% - <br>50% - <br>60% - <br>70% - <br>80% - <br>90% - <br>100 % packet loss - 0 % of flights tracked |


### Network Remote ID projections

TBC

## Acknowledgements

We are thankful to [Dr. Karthik Balakrishnan](https://www.linkedin.com/in/kbalakri) for his comments and review.


## Revision History

| Version | Date | Author | Change comments |
| --- | --- | --- | --- |
| 0.6 | 6-July-2020 | Dr. Hrishikesh Ballal | Added QGIS / OSM data and maps |
| 0.2 | 3-July-2020 | Dr. Hrishikesh Ballal | Fixed formatting |
| 0.1 | 2-July-2020 | Dr. Hrishikesh Ballal | Removed UTM specific details and renamed   |