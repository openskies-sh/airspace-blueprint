
# Comprehensive Airspace Simulation

## Table of Contents

- [Comprehensive Airspace Simulation](#comprehensive-airspace-simulation)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Goals](#goals)
  - [Scenarios](#scenarios)
    - [Extrapolating real world scenarios from TCL demos](#extrapolating-real-world-scenarios-from-tcl-demos)
  - [Flight projections and network load](#flight-projections-and-network-load)
    - [Broadcast Remote ID](#broadcast-remote-id)
    - [Broadcast Remote ID bandwidth](#broadcast-remote-id-bandwidth)
    - [WiFi Aware range](#wifi-aware-range)
  - [Acknowledgements](#acknowledgements)
  - [Revision History](#revision-history)

## Introduction

The aim of this document is to develop operating parameters and performance envelope for software in the context of UTM / U-Space. The UTM eco-system software that includes for e.g. [DSS software](https://github.com/interuss/dss), [registry](https://github.com/openskies-sh/aircraftregistry), [identity and authentication](https://github.com/openskies-sh/flight_passport) are essentially a series of complex interconnected technologies and processes that need comprehensive testing at different levels of the stack.

## Goals

There are two major goals of this document, to develop a assessment of the security standards, hardware tests and develop data on the operational requirements for a airspace. It hopes to address the questions for policy makers around design of airspace, developing performance of de-confliction algorithms etc. At a broader level, the goal of this document is to develop an understanding of the resilince / brittleness of the airspace as it gets more active. Finally, this document hopes to develop a comprehensive software suite to test these scenarios.

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
| People in AOI | A 406 m radius circle gives a area of 517585.04 m<sup>2</sup> or 0.51758 km<sup>2</sup> area. According to [Wikipedia](https://en.wikipedia.org/wiki/Reno,_Nevada), the population density of Reno is about 820 / km<sup>2</sup> or 425 people in our area of interest.  |  A 406 m radius circle gives a area of 517585.04 m<sup>2</sup> or 0.51758 km<sup>2</sup> area. According to [Wikipedia](https://en.wikipedia.org/wiki/Corpus_Christi,_Texas), the population density of Corpus Christi is about 710 / km<sup>2</sup> or 366 people in our area of interest. |
| Urgent Delivery Flights | Assume that the urgent package delivery market with the following assumptions: 5% of the people are interested in urgent delivery (22 people in the area, they order urgent delivery twice a week (22 x 2 packages x 2 days) = **88 flights (back and forth)** | Assume that the urgent package delivery market with the following assumptions: 5% of the people are interested in urgent delivery (18 people in the area), they order urgent delivery twice a week (18 x 2 packages x 2 days) = **72 flights (back and forth)** |
| Metro Area Map | <img src="https://i.imgur.com/i8Cpz0C.png" height="400"> | <img src="https://i.imgur.com/vU9Ex7J.jpg" height="400"> |
| Metro Area size | Reno City has a population of 250,998 and a area of __274.2__ km<sup>2</sup> (Source: [Wikipedia](https://en.wikipedia.org/wiki/Reno,_Nevada)). | Corpus Christi Metro Area has a population of 326,554 and a area of __1,304__ km<sup>2</sup> (Source: [Wikipedia](https://en.wikipedia.org/wiki/Corpus_Christi,_Texas))|
| Flights per hour | For the entire Reno, NV area, we get the following: 5% of the people are interested in urgent delivery (12,550 people in the city), they order urgent delivery twice a week (12550 x 2 packages x 2 days) = 50,200 flights (back and forth). This means that every week there will be potentially **50,200 flights per week** in the area. For the sake of simplicity let us asssume that they will be during working hours and not on weekends: so 50,200 flights and 40 hours to fly them = **1255 flights per hour**  | For Corpus Christi, TX area, we get the following: 5% of the people are interested in urgent delivery (16328 people in the city), they order urgent delivery twice a week (16328 x 2 packages x 2 days) = 65310 flights (back and forth). This means that every week there will be potentially **65,310 flights per week** in the area. For the sake of simplicity let us asssume that they will be during working hours and not on weekends: so 65,310 flights and 40 hours to fly them = **1633 flights per hour** |

## Flight projections and network load

Assuming a 5% increase in demand in urgent deliveries, the right hand side chart shows the projected increase in the two city regions of interest <br> <img src="https://i.imgur.com/itZqIjO.png" width="400"> 

These are significant yearly flights in the region. We will now extrapolate the network load for brodcast and network remote ID per the published ASTM standard. The standard talks about broadcast ID over Bluetooth 4.0, 5.0 and WiFi and network Remote ID via the DSS.

### Broadcast Remote ID

In this section, we develop projections of broadcast Remote ID messages, the ASTM spec says that the UAS can use either Wifi or Bluetooth 4.0 or Bluetooth 5.0 to transmit the information as part of WiFi Aware for e.g. advertisement messages.

|Broadcast Remote ID |  |
| ------------- |-------------|
| Average flight return time (Assuming average speed of 35 km/hr and average distance of 10 km) | __34 mins__ |
| Number of broadcast Remote ID messages per flight  | __2040__ (1 per second)  |
| Minimum Mandatory fields (Basic ID Message + Location / Vector Message) | __50 bytes__ |
| Maximum data message size (uncompressed) if all fields used e.g. Authentication System Message and Operator ID | __150 bytes__ |

### Broadcast Remote ID bandwidth

Assuming a average flight time of 34 minutes, one flight will emit 2040 messages with a minimum of 2040 * 50 = **102,000 bytes** and maximum 2040 * 150 = **306,000 bytes** per return flight.

| Reno, Nevada | Corpus Christi, Texas|
| ------------- |-------------|
| Flight density from above: 1255 flights / hour and a average flight time of 34 minutes we can assume that almost half the flights are in the air at any given time. This leads to the following bandwidth calculations: Assuming 630 flights * 102,000 bytes = 64260000 bytes or **64.26 MB / second** minimum in the airspace and a maximum of 630 flights * 306,000 bytes = 192780000 bytes or **192.78 MB / second** throughout the entire region.   | Similarly, for Corpus Christi the 1633 flights / hour and a average flight time of 34 minutes we can assume that almost half the flights are in the air at any given time. This leads to the following bandwidth calculations: Assuming 820 flights * 102,000 bytes = 83640000 bytes or **83.64 MB / second** minimum in the airspace and a maximum of 820 flights * 306,000 bytes = 250920000 bytes or **250.78 MB / second** throughout the entire region. |

### WiFi Aware range

Typically the range of a WiFi signal is about 125-150 ft. or 38 - 45 meters. For the sake of simplicity we assume 40 meters. A drone flying at 35 km / hour (9.7 m/s) will cover 40 meters in rougly 4 seconds.

With almost 1255 flights / hour and almost half of them in the air at any time, at the most trafficed locations in the city (e.g. downtown) will have the most number of flights in the air. For the sake of simplicity we can assume that 3% of flights will be flying through downtown. This means that the receiver should be able to process **37 broadcast messages every second** in the Reno area.

## Acknowledgements

We are thankful to [Dr. Karthik Balakrishnan](https://www.linkedin.com/in/kbalakri) for his comments and review.


## Revision History

| Version | Date | Author | Change comments |
| --- | --- | --- | --- |
| 0.1 | 2-July-2020 | Dr. Hrishikesh Ballal | Removed UTM specific details and renamed   |