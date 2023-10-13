# Whipple-Carvalo bicycle model

## Overview

The aim of this project is to investigate the conditions of stability of bicycle system modeled after Whipple-Carvalo model. 

This part of the project visualizes bicycle system behavior using Matlab.

For more information regarding the project please visit project page.

---

# Logic behind

In our world the bicycle is a system that has a couple of equilibriums. The one where the bicycle is laying on the ground is the stable equilibrium and the one in which it is standing perpendicularly to the ground is the unstable equilibrum. The one we are interested in is the unstable equilibrium, the case where the bicycle's position is perpendicular to the ground.
Since it is an unstable equilibrium and the system unevitably will face some disturbances we need to include a controller that will help remain desired position with the input to the system. 

The bicycle model system is constructed using a feedback controller. In each time frame the controller has the information about the current state of relevant parameters in the system and based on them it creates an input that is applied in the system and which is used to stabilize the bicycle's behaviour. 

In real life the controller is the rider since with maneuvering the bicycle handles and applying some torque to them the rider can achieve stabilizable state.

Since modelling modelling a controller that will imitate rider's behaviour is quite challenging We will restrict ourselves to the simpler case in which the bicycle does not have a rider and the controller then represents free movement of the bicycle fork when the bicycle is moving with a certain speed.

---

## Setup
**Note:** This project is written with Matlab, and you will need Matlab software to run it.

- To clone the repository to your local directory run: 
~~~
$ git clone https://github.com/letber/Whipple-Bicycle
~~~

-  In order to open main module in Matlab run this command in the terminal:
~~~
$ matlab bicycle.m
~~~ 

Alternatively you can also open Matlab IDE and run main module $bicycle.m$ in it.

---

## Visualization examples

In each of of these visualizations the speed remains constant and the initial parameters are:

Fork tilt angle = 0
Bicycle tilt angle = 5*pi/180

**First case:**
Speed = 3.5 m/s

[![Whipple-Carvalo bicycle model v3.5](https://img.youtube.com/vi/Paf1Ywdv4PY/maxresdefault.jpg)](https://www.youtube.com/watch?v=Paf1Ywdv4PY&ab_channel=danyloG)

**Second case:**
Speed = 4 m/s

[![Whipple-Carvalo bicycle model v4](https://img.youtube.com/vi/nCJ1wVmVlJw/maxresdefault.jpg)](https://www.youtube.com/watch?v=nCJ1wVmVlJw&ab_channel=danyloG)

**Third case:**
Speed = 5 m/s

[![Whipple-Carvalo bicycle model v5](https://img.youtube.com/vi/KqlnKYFQC9A/maxresdefault.jpg)](https://www.youtube.com/watch?v=KqlnKYFQC9A&ab_channel=danyloG)

**Fourth case:**
Speed = 6.1 m/s

[![Whipple-Carvalo bicycle model v6.1](https://img.youtube.com/vi/qtyIAezpxPk/maxresdefault.jpg)](https://www.youtube.com/watch?v=qtyIAezpxPk&ab_channel=danyloG)
