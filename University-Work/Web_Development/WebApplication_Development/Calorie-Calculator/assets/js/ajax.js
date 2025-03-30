import { getQuery } from "./search.js";

getQuery();
  export function getAPI(query) {
    fetch("https://api.api-ninjas.com/v1/nutrition?query=" + query, {
      method: "GET",
      headers: {'X-Api-Key': 'mso38VpSXph+x1nJdYVx5g==L8auNEWbEjoTSNOX'},
      contentType: 'application/json',
    })
    .then((response)=> {
    return response.json();
    })
    .then((data) =>{
      console.log(data[0])
      let tableData = "";
      data.map((values) =>{
        tableData += 
      `<tr>
        <td>${values.name}</td>
        <td>${values.calories}</td>
        <td>${values.serving_size_g}</td>
        <td>${values.fat_total_g}</td>
        <td>${values.fat_saturated_g}</td>
        <td>${values.protein_g}</td>
        <td>${values.sodium_mg}</td>
        <td>${values.potassium_mg}</td>
        <td>${values.cholesterol_mg}</td>
        <td>${values.carbohydrates_total_g}</td>
        <td>${values.fiber_g}</td>
        <td>${values.sugar_g}</td>
      </tr>`;
      });
      document.getElementById("tableBody").innerHTML = tableData
    })
  }
    




    
    



