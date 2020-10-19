# XTern FoodieX WorkAssessment
Here is my WorkAssessment for the XTern Program

I will be describing all of the files and their uses here:

As an introduction, as I first saw the restaurant list, I was overwhelmed. Although I had the knowledge to be able to search through the data set, I couldn't help but wonder: "it must be very overwhelming for people to decide where to eat with this many choices!"

Consequently, I used this opportunity to focus more on the consumer aspect, and create insights and tools to help the people using FoodieX.

# Note:
In all the code files, I used R, and thus had to import the given data source from where I had it stored. If you are planning to use the code, you will most likely need to change the location of the data source files to make sure you are importing it from the correct location. 
For convenience, the places where I am importing the data source is line 3 of all 3 R files.
Additionally, when running the code just double check that everything prior to the calls to functions have been run.

# Estimated Time
One of the first things I noticed while looking through the data was at how consistent the average cooking time is across all the restaurants.
Looking at "RestaurantsVsCookTimeGraph.pdf", it becomes apparent how despite the overwhelming amount of choices of food to choose from, most people will have to wait at least 30 minutes before getting their food. But how long? It's not just a matter of cook time, it's also a matter of how long the drive will take.

Consequently, I created the program located in "XTernProjectEstimatedTime.R". This R code enables anyone to simply say what restaurant they would like to order from, and their current location, and the code will generate an estimated time for how long they should expect to get their food.

They main assumption this function makes is the average speed limit in the area. The speed limit is assumed to be 55 mph. Additionally, due to not having access to the local area's traffic patterns, the code cannot take that into account.

If you would like to try the code out for yourself, the line 41 is where the user inputs the required information to calculate the estimated time.
Ideally, this function would also be combined with the generic search algorithm described last to even further recommend restaurants to the user.

# Rating Per Cost
There are so many food options to choose one, but which restaurants give the best food for their cost?

Looking at "RatingPerCostGraph.pdf", there appears to be a trend between the Rating of a restaurant and that restaurant's average cost. Specifically, the relationship can be modelled by the function "Avg Cost" = 6.79073("Rating")^2 - 40.8101(Rating) + 79.518. This equation was derived by Tableau, with an R^2 value of 0.564. So although the relationship isn't strong, there is still a slight correlation.

So with this correlation being present but weak, there are going to restaurants that diverge from this trend. How can our consumers take advantage of this fact?

The "XTernProjectRatingPerCost.R" file is code that was made for the frugal consumer who would like to maximize the quality of food they get for their money.
Line 32 in the file is a call to a method that takes a data frame as an input (for example, the provided data FoodieX data), and orders the given restaurants from highest Rating per Cost to lowest. The function also takes a boolean and integer input. This is due to the fact that some restaurants may only have 5 votes determining their rating. To avoid getting misled, one may set the boolean value to true and give an integer for the minimum number of votes needed. Consequently, the code will then additionally filter out any restaurants that have less than the specified number of votes.

By doing this, the consumers will be able to look at which restaurants have the best rating per cost ratio, and thus maximize the quality of food they get per dollar.
Similarly to the Estimated Time algorithm, this code can be combined with the generic search function (discussed below) by inputting the generic search's output into this code's input, allowing the user to make an even more informed decision on where they would like to eat.

# Generic Search
As previously mentioned, anyone looking at the list of restaurants surely would be overwhelmed by the number of choices - simply by looking at the left hand graph of "RestaurantsVsCookTimeGraph.pdf" one can see how hard it may be to choose where to eat.

To remedy this, I created a generic search algorithm to help the consumer narrow down their choices on where they might want to eat. The "XTernProjectRestSearch.R" file contains this search algorithm. Line 65 is where the search is called. In the call, the user can specify the maximum cooking time, the cuisine, minimum rating, maximum cost, and maximum distance (in miles) they would like the restaurants to have. Line 70 will output just the names of the restaurants that fit the specifications, while line 73 outputs the specified restaurants along with the restaurant's information.

Of course, if the user is indifferent towards any of the categories, they can simply not include that in the specification and the code will take that into account. One thing to note is that if the user wishes to choose no preference towards distance, maxDis, longitude, and latitude all must be deleted.

Although this insight involves less analysis than code, I believe that this still serves as an insight into the given data source, while also providing a very powerful tool to the users of FoodieX, especially when combined with the above 2 algorithms.

# Clustered Map
In order to avoid the clutter of all of restaurants in "RestaurantsVsCookTimeGraph.pdf", I created "ClusteredMapOfRestaurants.pdf". Each dot on the map represents a square area of 9 square miles, with the color of each dot representing the amount of restaurants within each area.

This map serves 2 main purposes: to identify potential FoodieX pickup zones and to identify locations where FoodieX may want to add more restaurants.

Looking at the map, there are many places that contain fewer than 10 restaurants. These locations are primarily on the border of the FoodieX zone, but there are some locations in the middle of the zone that also contain few restaurants. Consequently, users in those areas are forced to choose between either limited options of restaurants, or longer delivery times (which they can calculate using the above the estimated time algorithm). In order to limit the amount of people that have to make such sacrifices, FoodieX may want to seek out other restaurants within these areas in order to provide more options for the users in those areas.

Additionally, the map can be used to determine potential FoodieX pickup locations. For example, depending on how many pick-up locations are being provided, it may be beneficial to put a pickup location in each area with more than 15 restaurants. Alternatively, it may also be beneficial to have a pickup location in each dot due to the fact that the dots are 6 miles a part. If it turns out not to be cost effective to have pickup locations in the areas with few restaurants, another solution could consist of a hybrid, with pickup locations in the populated areas while having delivery drivers go to the areas with fewer restaurants.

# Thank you!
This concludes my XTern Work Assessment. I just wanted to take this extra space to say thank you to the graders for taking the time out of your day to go through all of these applications! I hope you have a great day!



