var Sudoku = function(board_string) {
  var board = new Board(board_string);

  this.solve = function() {
    
  };

  this.printBoard = function() {
    board.eachRow(function(row) {
      console.log(row); 
    };
  };
};

var Board = function(board_string) {
  var cells = board_string.split('');

  this.eachRow(callback) {
    for (var row = 0; row < 9; row ++) {
      callback(cells[row * 9,
  };
};

var sudoku = new Sudoku('096040001100060004504810390007950043030080000405023018010630059059070830003590007');

sudoku.solve();
