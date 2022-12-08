param dayCount >= 1, integer;
set Days := 1..dayCount;


param miningValue := 100;
param miningDuration := 20;
param advancedMiningValue := 60;
param GameDuration := 2200;
param workerCount := 10;

set Buildings;
param buildingCost{Buildings} >= 0, integer;
param buildingTime{Buildings} >= 0, integer;
param buildingValue{Buildings} >= 0, integer;
param initialGold := 0;
param initialAdvancedMining := 0;

var builds{Days, Buildings} >= 0, integer;
var mines{Days} >= 0, integer;

var totalValuePrintf; #csak így íratja ki a printf
var totalCostPrintf; #csak így íratja ki a printf
var totalDurationPrintf; #csak így íratja ki a printf
var totalGoldPrintf; #csak így íratja ki a printf
var gold{0..dayCount} >= 0, integer;
var advanedMining{0..dayCount} >= 0, integer;

s.t. doSomething{d in Days}:
    sum{b in Buildings} builds[d, b] + mines[d] = workerCount;

s.t. initializeGold:
    gold[0] = initialGold;

s.t. initializeAdvancedMining:
    advanedMining[0] = initialAdvancedMining;

s.t. calcGold{d in Days}:
    gold[d] = gold[d-1] + mines[d] * miningValue + advanedMining[d] - sum{b in Buildings} builds[d, b] * buildingCost[b];

s.t. limitGold{d in Days}:
    0 <= gold[d];

s.t. buildOnlyTwo{b in Buildings}:
    sum{d in Days} builds[d, b] <= 2;

s.t. isLimberMillUp{d in Days}:
    advanedMining[d] = advanedMining[d-1] + sum{b in Buildings: b = 'LumberMill'} builds[d, b] * advancedMiningValue;

s.t. buildInTime:
    sum{d in Days} mines[d] * miningDuration + sum{d in Days, b in Buildings} builds[d, b] * buildingTime[b] <= GameDuration;


s.t. getTotalValue:
    totalValuePrintf = sum{d in Days, b in Buildings} builds[d, b] * buildingValue[b];

s.t. getTotalCost:
    totalCostPrintf = sum{d in Days, b in Buildings} builds[d, b] * buildingCost[b];

s.t. getTotalGold:
    totalGoldPrintf = sum{d in Days} (mines[d] * miningValue + advanedMining[d]);

s.t. getTotalDuration:
    totalDurationPrintf = sum{d in Days} mines[d] * miningDuration + sum{d in Days, b in Buildings} builds[d, b] * buildingTime[b];

maximize TotalValue: totalValuePrintf;

solve;

printf "\nTotal Value: %g\n", totalValuePrintf;
printf "\nTotal Cost: %g <= Total Gold: %g\n", totalCostPrintf, totalGoldPrintf;
printf "\nTotal Duration: %g\n\n", totalDurationPrintf;

for{d in Days: mines[d]}{
        printf "Day: %s\t\tMining Value: %s\tAdvanced Mining: %s\tGold at the end of the day: %s\n",d,(mines[d] * miningValue), advanedMining[d], gold[d];
}
for{d in Days, b in Buildings: builds[d, b]}{
        printf "Day: %s\t\tBuilding Value: %s\tBuilding Cost: %s\tBuilding: %s\n",d,(builds[d, b] * buildingValue[b]), (builds[d, b] * buildingCost[b]),b;
}