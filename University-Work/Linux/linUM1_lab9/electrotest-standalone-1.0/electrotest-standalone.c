#include <stdlib.h>
#include <stdio.h>

#define MAX_RESISTOR_COUNT 3
#define E12_ROWS 8
#define E12_COLUMNS 12

//https://www.gnu.org/software/c-intro-and-ref/manual/html_node/include-Syntax.html
//https://stackoverflow.com/questions/1240761/manipulating-the-search-path-for-include-files

const float e_helper(float remaining_resistance);
int e_resistance(float orig_resistance, float* res_array);
float calc_power_r(float volt, float resistance);
float calc_power_i(float volt, float current);
float calc_resistance(int count, char conn, float *array);



int main(void){

    float voltage;
    char conn_type;
    int comp_count;
    float replace_array[3];

    // Fråga efter spänning
    printf("Ange spänningskälla i V: ");
    scanf("%f", &voltage); // man 3 scanf

    // Fråga efter koppling
    printf("Ange koppling[S | P]: ");
    scanf(" %c", &conn_type);

    // Fråga efter antal komponenter
    printf("Ange antal Komponenter: ");
    scanf("%d", &comp_count);

    float* resistances = malloc(comp_count * sizeof(float));  //alloc()
    // -> ([3]) [7] [6] [1]
 
    // Fråga efter moståndet för respektive resistor
    for (int i = 0; i < comp_count; i++) {
        printf("Komponent %d i ohm: ", i + 1);
        scanf("%f", &resistances[i]);
    }

    // Anrop till resistance
    float total_resistance = calc_resistance(comp_count, conn_type, resistances);
    printf("Ersättningsresistans:\n%.1f ohm\n", total_resistance);

    // anrop till power
    float total_power_r = calc_power_r(voltage, total_resistance);
    printf("Effekt: \n%.2f W\n", total_power_r);

    // Anrop till component
    int num_components = e_resistance(total_resistance, replace_array);
 
    printf("Ersättningsresistans i E12-serien kopplade i serie:\n");
    for (int i = 0; i < num_components; i++) {
        printf("%g\n", replace_array[i]);
    }


    return EXIT_SUCCESS;
}

//libComponent:
const float e_helper(float remaining_resistance){
    // Eftersom det är väldigt få fasta värden så är jag inte så bekymrad
    // över att behöva iterera över hela matrisen flera gånger.
    // I den här versionen av programmet spelar det ingen roll att det är en
    // 2D-array istället för en 1D egentligen, det fanns en tanke om att 
    // testa huruvida orig_resistance var delbart med 10, 100, 1000 osv för att
    // på så sätt välja rätt rad.
    const float etwelve[E12_ROWS][E12_COLUMNS] = { 
        {1.0, 1.2, 1.5, 1.8, 2.2, 2.7, 3.3, 3.9, 4.7, 5.6, 6.8, 8.2},
        {10, 12, 15, 18, 22, 27, 33, 39, 47, 56, 68, 82},
        {100, 120, 150, 180, 220, 270, 330, 390, 470, 560, 680, 820},
        {1000, 1200, 1500, 1800, 2200, 2700, 3300, 3900, 4700, 5600, 6800, 8200},
        {10000, 12000, 15000, 18000, 22000, 27000, 33000, 39000, 47000, 56000, 68000, 82000},
        {100000, 120000, 150000, 180000, 220000, 270000, 330000, 390000, 470000, 560000, 680000, 820000},
        {1000000, 1200000, 1500000, 1800000, 2200000, 2700000, 3300000, 3900000, 4700000, 5600000, 6800000, 8200000},
        {10000000, 12000000, 15000000, 18000000, 22000000, 27000000, 33000000, 39000000, 47000000, 56000000, 68000000, 82000000}
    };
    for (int i = 7; i >= 0; i--){
        // Rows
        for (int j = 11; j >= 0; j--){
            // Columns
            if (remaining_resistance/etwelve[i][j] >= 1){
                // Eftersom vi räknar baklänges kan vi returnera första bästa
                return etwelve[i][j];
            }
        }
    }
    // Returnera noll om det inte finns någon resistor som passar
    return 0;
}

int e_resistance(float orig_resistance, float* res_array){ // 
    // En annan variant är ju att bara fortsätta tills resistanes är 0
    // men bara spara max de första tre.
    int res_counter = 0;
    for (int i = 0; i < MAX_RESISTOR_COUNT; i++){
        float new_value = e_helper(orig_resistance); 
        res_array[i] = new_value; 
        orig_resistance -= new_value;
    }
    for (int i = 0; i < MAX_RESISTOR_COUNT; i++){
        if (res_array[i] > 0) res_counter++;
    }
    return res_counter; // Antal ersättningsresistorer 
}

//libPower:
// Beräknar effektutvecklingen med hjälp av spänning och resistans
float calc_power_r(float volt, float resistance) { // spänning och motståndsvärdet
  // P = U^2 / R (Spänning i kvadrat delat i resistansen)
 // P = volt * volt / resistance;
  return volt * volt / resistance;
}

// Beräknar effektutvecklingen med hjälp av spänning och ström
float calc_power_i(float volt, float current) { // spänningen och ström
  // P = U * I  (Spänning gånger strömmen)
  //P = volt * current;
  return volt * current;
}

//libResistance:
float calc_resistance(int count, char conn, float *array){

    if (array == NULL) return -1; // om arrayen är tom skickas en felkod
    if (count <= 0) return -1; // om count är mindre eller likamed 0 så skickas en felkod

    float resultResistance = 0.0; // ska hålla det slutgiltiga resistansvärdet

    if (conn == 'S' || conn == 's') { // kontrollerar om komponenterna är seriekopplade
        for (int i = 0; i < count; i++) // loppar igenom alla komponenter
        {
            resultResistance += array[i]; // summerar varje komponents resistance till the slutgiltiga resistansvärdet
        }
    }
    else if (conn == 'P' || conn == 'p'){ // kontrollerar om komponenterna är parkopplade
        for (int i = 0; i < count; i++) // loopar igenom alla komponenter 
        {
            if (array[i] == 0) return 0; // om någon komponent har 0 i resistansvärde så returneras 0 enligt uppgiftens krav
            resultResistance += 1 / array[i]; // eftersom det är en parallelkoppling så måste vi lägga till den omvända resistansen dvs 1/R till den slutgiltiga resistansen och inte bara resistansvärdet direkt
            
        }
        resultResistance = 1 / resultResistance; // eftersom det är en parallelkoppling så måste vi dela 1 med den resulterande resistansen för att få den omvända resistansen 
    }
    else{  // ifall conn inte är S eller P så returneras en felkod eftersom argumentet kommer vara ogiltigt
        return -1;
    }

    return resultResistance;  // returnerar den slutgiltiga resistansen

}
