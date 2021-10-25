// contents of viz.js
define('viz', ['d3'], function (d3) {
    function draw(container) {
       d3.select(container).append("svg").append(… etc.
    }
    return draw;
});
// this final line prints a message in the output cell when viz.js is loaded
element.append('Loaded 😄 ');