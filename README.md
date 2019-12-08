#  MVVM RX Coordinator  

A sample app to experiment with:
- MVVM
- RxSwift
- Coordinator
- Core Data
- TableView
- Loding Animation
- Error Message View


This project use  GitHub web API to retrieve all open issues associated with the firebase-ios-sdk repository and display a list of issues to the user - the UI should be something like:

- Order by most-recently updated issue first.
- Issue titles and first 140 characters of the issue body should be shown in the list.
- Allow the user to tap an issue to display next screen (detail screen) containing all comments for that issue.
- All the comments should be shown on the detail screen.
- The complete comment body and user name of each comment author should be shown on this screen.
- If the comments are not available for a particular issue then its show a popup with message (Comments not available).

It also have persistent storage  for caching data so that the issues are only fetched once in 24 hours and get current data.


