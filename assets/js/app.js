// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".

// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import socket from "./socket"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

function start_connection() {
  channel = socket.channel("photo_analyzer:live", {})
  channel.join()
    .receive("ok", resp => {
      react_to_payload(resp)
      if ( file_full_path != "")
        channel.push("start_load", file_full_path)})
    .receive("error", resp => { console.log("Unable to connect", resp) })

  channel.on("refresh", payload => {
    react_to_payload(payload)
  });
}

start_connection();

function make_rgb(colors) {
  var ans = "rgb(" + colors.r + "," + colors.g + "," + colors.b + ")";
  return ans;
}

function react_to_payload(pyld) {
  console.log("refresh received", pyld);

  if('histogram' in pyld) {
    var redVals = pyld.histogram.r;
    var greenVals = pyld.histogram.g;
    var blueVals = pyld.histogram.b;
    redVals.unshift("red");
    greenVals.unshift("green");
    blueVals.unshift("blue");
    redChart.load({
      columns: [redVals],
    });
    greenChart.load({
      columns: [greenVals],
    });
    blueChart.load({
      columns: [blueVals],
    });
  }
  if('dominant' in pyld) {
    for (var i = 0; i < pyld.dominant.length; i++) { 
      $("#" + (i + 1) + ".dominant").css("background-color", make_rgb(pyld.dominant[i]))
    }
  }
}

function chart_generator(domItem, name) {
  return c3.generate({
    bindto: domItem,
    data: {
      columns: [[name, 0]],
      type: "bar",
      colors: {
        red: '#ff0000',
        green: '#00ff00',
        blue: '#0000ff'
      }
    },
    bar: {
        width: 1
    },
    padding: {
      top: 0,
      bottom: -26,
      left: 0,
      right: 0
    },
    axis: {
      x: { show: false },
      y: { show: false, max: 256},
    },
    legend: {
      hide: true
    }
  });
}

var redChart = chart_generator("#red", "red");
var blueChart = chart_generator("#blue", "blue");
var greenChart = chart_generator("#green", "green");






