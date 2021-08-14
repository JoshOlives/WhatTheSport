# WhatTheSport <br>
*Team members:* Joshua Olivares, Adam Martin, Zhongyi Wang, Adam Gluch <br>
*Name of project:* WhatTheSport <br>
*Dependencies:*
- Xcode 12.5
- Swift 5
- Pods
  - Firebase
  - Firebase/Auth
  - Firebase/Firestore
  - FirebaseFirestoreSwift
  - Firebase/Storage 
<!-- end of the list -->
*Special Instructions:*
- You have to open the file WhatTheSport.xcworkspace (as opposed to the file
WhatTheSport.xcodeprog).
- For best results use an iphone 11 pro max though other devices are supported (except ipads)
- Before running the app, run "pod install" inside the WhatTheSport folder where the
podfile is located
- When changing profile pictures there might be a slight delay to update the picture in the
sliding menu since uploading the image and retreiving it takes some time
- Since notifications are tied to game times if you want to see that notifications work
you can uncomment lines 97, 105, 114, and 123. This will cause a notification to go off
10 seconds from the current time for any game. 
- Landscape mode not supported
<!-- end of the list -->


| Feature | Description | Who/Percentage worked on |
| ------- | ----------- | ------------------------ |
| Login | allow users to login | Joshua (100%) |
| sign up | allow users to sign up | Joshua (100%) |
| darkmode | correctly update the color scheme according to darkmode setting | Joshua (100%) |
| sliding menu | allows user to access settings, profile, or sign out without leaving the home page| Joshua (50%) Zhongyi (50%)|
| settings | allows user to enable dark mode or access their profile | Joshua (10%) Zhongyi (90%) |
| account page | allows user to view their information. Users can change their username, following sports/teams, profile picture from here or request a change password email or sign out   | Joshua (30%) Zhongyi (70%) |
| Filtering | Filter the schedules or feed according to uesr filters | Adam Martin (100%) |
| Feed | Allow users to see their feed and create posts | Adam Martin (100%) |
| followed sports | allows user to choose what sports to follow | Adam Gluch (100%) |
| change profile picture | allows user to change profile picture and preview image | Zhongyi (100%) |
| Comments | Allow users to view comment on posts and create comments | Adam Martin (100%) |
| game data | set up data for games in Firestore | Zhongyi (100%) |
| followed teams | allows user to choose what teams to follow | Adam Gluch (100%) |
| schedules page | allows user see upcoming game schedules | Joshua (50%) Zhongyi (50%) |
| Calendar and local notifications | allows user to set a local notification or create an event on their calendar for games | Joshua (100%) |
| reset password | allows user to request a password reset email | Joshua (100%) |
| Filters page | allows users to modify their filters | Joshua (10%) Zhongyi (90%) |
