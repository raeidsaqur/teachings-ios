<h1>Learning objectives</h1>
Understand gesture recognizers and their individual methods
Understand using multiple gesture recognizers together on the same view

<h1>Setup</h1>
You’ll be creating a virtual pet that you will interact with through gesture recognizers.

Start by cloning the repo: https://github.com/lighthouse-labs/iOS-Student-Phonagotchi

Create a new class that will represent the pet. This will be the model of the MVC structure of the app. As you go through the gesture recognizers, there will be interactions between the state of the pet model and the user actions. As you do the assignment, add methods and properties to the pet object as you deem appropriate for the goals.

<h1>MVP User Stories</h1>
As a user, I can pet my phonagotchi
Create a pan gesture recognizer that will allow you to pet the phonagotchi. Have it so that if the user pets too fast, it gets grumpy. Use your own judgement about how fast is too fast, and have a method on the model that represents the petting and takes a velocity. Add a readonly property that says if the pet is grumpy or not.

As a user, I can feed my phonagotchi
There is a bucket.png and apple.png. Create 2 views that represents an apple in a basket over at the bottom left corner of the view. Add a pinch gesture recognizer so that when you pinch over the apple, it will add a new apple and will track it so that if you drop the food over the phonagotchi, it will eat the food, and if you drop it anywhere else, it will fall off the bottom of the screen (just use a regular UIKit animation call for this).

As a user, I can interrupt the resting phonagotchi (Optional)
 the ability to have your pet sleep for a given amount of time, and have that restore an amount of restfulness. As the pet goes without sleep, it gets cranky and the speed at which you can pet it without getting it mad goes slower and slower. Once it hits 0 restfulness, it goes to sleep. It wakes up again in a minute fully rested. If you shake the phone while it is sleeping, it wakes up but has a restfulness level proportional to the amount of time it spent sleeping.
