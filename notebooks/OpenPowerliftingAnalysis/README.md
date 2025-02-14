# Statistical Analysis of the Largest Powerlifting Database

In the world of powerlifting, formulas are used to evenly distribute efforts between weight classes. It is veryt easy to put on bodyweight to lift the most weight, but not everyone is capable of doing that. Therefore, formulas are developed to evenly distribute effort between weight classes. The formulas are able to give the lower weight classes a better advantage than they would if a powerlifting meet used a strict total. Using the largest powerlifting database in the world, this app was created to look at different DOTS scores and predict outcomes of age divisions based on bodyweight. Openpowerlifting.org is a free open source database that houses self reported data from everywhere around the world. The data is free to download, as long as credit is given to the organization.

## DOTS Formula

DOTS (Dynamic Object Team Rating System) is a popular formula that has been built off of the Wilks, which is also a popular formula but biases the middleweight classes. The DOTS is an attempt to reduce the middleweight bias seen in the Wilks using total weight lifted and the lifters bodyweight.

## Maps

The Shiny app uses maps to show different DOT scores around the world. Because the data from open powerlifting is self reported, many countries do not have DOTS scores available. It is a nice tool to see how a powerlifter would compare to the max DOTS scores world wide.

## Mens/Womens Data

The mens and womens data are identical but use different formulas. The coefficients used in the DOTS scores change based on sex. Weight classes are different as well, with women having lighter weight class options than men. A lifter is able to input their weight and age class and see their probability of winning their division within the weight range. A DOTS calculator is also provided to see where the lifter is at with their squat, bench and deadlifts.