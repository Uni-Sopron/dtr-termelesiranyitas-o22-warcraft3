param workerCount >= 1, integer;
set Workers := 1..workerCount;

set Buildings;
param buildingCost{Buildings} >= 0, integer;
param buildingTime{Buildings} >= 0, integer;
param buildingValue{Buildings} >= 0, integer;
param initialGold := 1600;
param GameDuration := 2000;

var builds{Workers, Buildings} binary;
var totalValuePrintf; #csak így íratja ki a printf
var totalCostPrintf; #csak így íratja ki a printf

s.t. limitBuldCost:
    initialGold - sum{w in Workers, b in Buildings} builds[w, b] * buildingCost[b] >= 0;

s.t. haveToBuildAtLeastOne{w in Workers}:
    sum{b in Buildings} builds[w, b] = 1;

s.t. buildInTime:
    sum{w in Workers, b in Buildings} builds[w, b] * buildingTime[b] <= GameDuration;

s.t. buildOneBuildingMaxTwoTimes{b in Buildings}:
    sum{w in Workers} builds[w, b] <= 3;

s.t. getTotalValue:
    totalValuePrintf = sum{w in Workers, b in Buildings} builds[w, b] * buildingValue[b];

s.t. getTotalCost:
    totalCostPrintf = sum{w in Workers, b in Buildings} builds[w, b] * buildingCost[b];

maximize TotalValue: totalValuePrintf;

solve;

printf "\nTotal Value: %g\n", totalValuePrintf;
printf "\nTotal Cost: %g\n\n", totalCostPrintf;

for{w in Workers, b in Buildings: builds[w, b]}{
        printf "Worker: %s\tBuilding Value: %s\tBuilding Cost: %s\tBuilding: %s\n",w,(builds[w, b] * buildingValue[b]), buildingCost[b],b;
}