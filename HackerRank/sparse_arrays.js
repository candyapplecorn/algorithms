function queryKeeper(strings = [], match) {
    this.queries = {};
    this.strings = strings;
    this.matchfn = match || ((a, b) => { return a == b });
    return this;
}

queryKeeper.prototype.run = function(query){
    if (this.queries[query])
        return this.queries[query];
    
    // count the number of times query appears in strings
    this.queries[query] = this.strings
        .filter(s => this.matchfn(s, query))
        .length
    ;
    
    return this.queries[query];
}

function processData(input) {
    //Enter your code here
    input = input.split('\n')
    var numstrings = input.shift()
    var strings = input.splice(0, Number(numstrings))
    var numqueries = input.shift()
    var queries = input
    
    var qk = new queryKeeper(strings);
    
    queries.forEach(q => console.log(qk.run(q)))
} 

process.stdin.resume();
process.stdin.setEncoding("ascii");
_input = "";
process.stdin.on("data", function (input) {
    _input += input;
});

process.stdin.on("end", function () {
   processData(_input);
});
