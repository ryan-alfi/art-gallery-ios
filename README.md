# Art Gallery iOS

Art Gallery App is an iOS app to help you browse and search museum's public artworks with Art Institute of Chicago data sources.

# Features

- **Artwork Gallery**: Browse through a diverse collection of artworks.
- **Infinite Scrolling**: Scroll down to load more artworks as you explore.
- **Search Functionality**: Easily find specific artworks by using the search bar.

## Architecture Layer

- **Domain** = Entities + Use Cases + Repositories
- **Data** = API DataSource (Network)
- **Presentation** = ViewModels + Views

## Getting Started

### Requirements

- Xcode Version 12.0+ Swift 5.0+

### Setup Project

1. Clone this repo: `git clone https://github.com/ryan-alfi/art-gallery-ios.git`
2. If they are not already on your machine, install Cocoapods: `sudo gem install cocoapods`
3. Run `pod install`
4. Open `ArtGalleryApp.xcworkspace` in Xcode

From there, you should be good to go to build and run ArtGalleryApp!

### How to use app

- Upon opening the app, you'll be taken to the main gallery screen.
- Scroll down to view more artworks. The app will automatically load additional artworks as you scroll.
- To search for a specific artwork, tap the search bar located at the top of the screen.
- Enter your search query, such as the artist's name or artwork title, into the search bar.
- As you type, the app will display relevant results in real-time.

https://github.com/ryan-alfi/art-gallery-ios/assets/7485614/98aa4fec-0692-4d5d-bca6-d282c8a06739

## Credits

- Artwork images and information sourced from [Art Institute of Chicago](https://api.artic.edu/docs/).
