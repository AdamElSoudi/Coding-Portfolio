import{getAPI} from "./ajax.js"

let searchBar = document.querySelector("#bar");

export function getQuery(){
  searchBar.addEventListener("keydown", function(query){
  if(query.which === 13){
    query.preventDefault();
    getAPI(query.target.value);
  }
  });
}