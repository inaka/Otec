## Otec
Newspapers reader


```
This app supports Swift 2.3
Swift 2.3 is currently in branch master.
```

![2016-06-16](https://raw.githubusercontent.com/inaka/Otec/master/Otec-Logo-Readme.png)

### What is Otec?

Otec is a sample (and simple) app to showcase our best open-source libraries : [EventSource](https://github.com/inaka/EventSource) , [Jayme](https://github.com/inaka/Jayme) and [Canillita](https://github.com/inaka/canillita). 
The objective of this app is to show how simple is to use Event Source and Jayme. The server we are using to test the app is Canillita, a simple server that provides newspapers and news by REST and SSE. I recomend you to take a look at its blogpost by [clicking here](inaka.net/blog/2016/01/04/canillita-your-first-erlang-web-server-V2/).

### How to try it?

In order to try Otec you'll have to either [download the code](https://github.com/inaka/canillita/archive/2.0.1.zip), compile it and run it or download the [latest compiled release](https://github.com/inaka/canillita/releases/download/2.0.1/canillita.zip) and run it. This will allow you to test the application running it in the simulator on the same machine the server is running in since the sample server url is pointing to localhost. However, you can change the ```CanillitaBackendLocalHostURL ``` constant to point to the address where Canillita is running and use it from any device you want. 

### Contact Us
If you find any **bugs** or have a **problem** while using this library, please [open an issue](https://github.com/inaka/Otec/issues/new) in this repo (or a pull request :)).

And you can check all of our open-source projects at [inaka.github.io](http://inaka.github.io)
