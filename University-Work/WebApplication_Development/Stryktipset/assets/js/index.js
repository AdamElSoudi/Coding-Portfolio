//Here I fetch the data provided in the link bellow and I also create an array I named "RESULTS" where I store all the data.
const info  = new XMLHttpRequest;
let RESULTS = [];
info.responseType = "json";
info.open("GET", "https://stryk.herokuapp.com/strycket2022");
info.send();

info.onload = function (){
  RESULTS = info.response;


//Here we get the table element from the html file.
const table = document.querySelectorAll("#table");

//These are the necessary variable arrays created and used throughout this code.
const rowNum = [];
const teamName = [];
const win = [];
const draw = [];
const lose = [];
const mark = [];


//This For loop goes through the array of playedGames which is 13 to fill every table row (tr). 
for (let index = 0; index < 13; index++) {

  //This is where the table rows are being created.
  const structure = document.createElement("tr");
  
  //Here the 13 collumns of each row is being filled with the game number (1-13).
  rowNum[index] = document.createElement("td");
  rowNum[index].appendChild(document.createTextNode(RESULTS.playedGames[index].gameNumber));
  
  //Here the next collumn writes out the team names of both teams that have played against eachother in that fixture.
  teamName[index] = document.createElement("td");
  teamName[index].appendChild(document.createTextNode(RESULTS.playedGames[index].teams[1].name + " -VS- " + RESULTS.playedGames[index].teams[2].name))

  //These 3 collumns are created to allow the checkmark to be placed .
  win[index] = document.createElement("td");
  draw[index] = document.createElement("td");
  lose[index] = document.createElement("td");

  //Here we create the checkmark from the span element in the html file.
  mark[index] = document.createElement("span")
  mark[index].className = "checkmark"

  const stem = document.createElement("div")
  stem.className = "stem"
  mark[index].appendChild(stem)

  const kick = document.createElement("div")
  kick.className = "kick"
  mark[index].appendChild(kick)


  //These if statements decide where the checkmark should be placed dependding on the outcome in the RESULTS file.
    if(RESULTS.playedGames[index].outcome == "1"){
    win[index].appendChild(mark[index]);
    }

    else if(RESULTS.playedGames[index].outcome === "X"){
    draw[index].appendChild(mark[index]);
    }

    else if(RESULTS.playedGames[index].outcome === "2") {
    lose[index].appendChild(mark[index]);
    }

  //This allows the program to go and create a new row below the previous ones and puts in the elements created above in this For loop.  
  const row = table.item(0).childNodes.item(1).appendChild(structure);
    row.appendChild(rowNum[index]);
    row.appendChild(teamName[index]);
    row.appendChild(win[index]);
    row.appendChild(draw[index]);
    row.appendChild(lose[index]);
}}