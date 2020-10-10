This project is adapted from https://medium.com/better-programming/how-to-use-a-swiftui-view-in-anarkit-scenekit-app-d6504d7b92d2
This is the first instance, where the rendered SwiftUI View is interactive and prevents the button in the other view controller from being pressed after it has been rendered.

Please run the code, tap on "Button" in the initial VC and then "init" to see the rendered SwiftUI view in AR. 
Try to tap on the Button in the middle of the SwiftUI View, it should be responsive to touch. 
Then try to go back to the previous VC (you might have to turn the camera so the SwiftUI view doesn't overlap with the 'back' button in the navigation bar, else it might block the touch interaction) and then tap on "Button" again. It shouldn't work this time.
