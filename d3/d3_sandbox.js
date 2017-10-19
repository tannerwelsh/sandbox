var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .ticks(10, "");

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var data = bestsellers;

var years = [];
for (var year in bestsellers) { years.push(year); }

x.domain(years);
y.domain([0, 20]);

svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis);

svg.append("g")
    .attr("class", "y axis")
    .call(yAxis)
  .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("text-anchor", "end");

svg.selectAll(".bar")
    .data(years)
  .enter()
    .append("rect")
      .attr("class", "bar")
      .attr("x", function(year) { return x(year); })
      .attr("width", x.rangeBand())
      .attr("y", function(year) { return y(count(bestsellers[year], "female")); })
      .attr("height", function(year) { return height - y(count(bestsellers[year], "female")); })
    .append("rect")
      .attr("class", "bar")
      .attr("class", "red")
      .attr("x", function(year) { return x(year); })
      .attr("width", x.rangeBand())
      .attr("y", function(year) { return y(20); })
      .attr("height", function(year) { return height - y(count(bestsellers[year], "male")); })

function count(books, gender) {
  var bookCount = 0;

  for (var i = 0; i < books.length; i++) {
    if (books[i].gender === gender) {
      bookCount += 1
    }
  }

  return bookCount;
}
