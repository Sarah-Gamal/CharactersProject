
# CharactersProject

The **CharactersProject** is a Swift-based iOS application that showcases a list of fictional characters. The app allows users to browse and filter characters using intuitive buttons and view detailed information about each character in a user-friendly interface.

## Features

- **Character Listing**: Displays a list of characters with their names and brief details.
- **Filtering Functionality**: Provides three buttons to filter the characters list based on predefined criteria.
- **Character Details**: Offers detailed information about a selected character, including biography, traits, and other relevant details.
- **Responsive Design**: Optimized for various iPhone screen sizes, with an effort to align with the design shown in the provided screenshots.  
   - **Spaces**: Maintained consistent margins and padding to ensure a clean layout. 
   - **Fonts**: Used system fonts for readability, mimicking the font sizes and styles visible in the screenshots, such as titles being bold and slightly larger, while subtitles and descriptions use medium-sized regular fonts.

## Technologies Used

- **UIKit**: Framework used for building the app’s interface and navigation.
- **Swift**: The programming language for iOS development.
- **URLSession**: Native iOS framework used for making network requests and parsing JSON responses.
- **Image Caching**: Implemented manual caching for images downloaded via URLSession to optimize performance and user experience.
- **Unit Testing**: Ensures code reliability and correctness.
- **MVVM Architecture**: The app is built using the Model-View-ViewModel (MVVM) architecture, separating the logic for easier maintenance and testing.

---

## Getting Started

### Prerequisites

- **Xcode 15.0** or later
- Swift 5.8 or later

### Instructions for Building and Running the Application

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Sarah-Gamal/CharactersProject.git
   cd CharactersProject
   ```
2. **Build and run the project**:
   - Select a simulator or connected device in Xcode.
   - Press `Cmd + R` to build and run the application.

---

## Assumptions and Decisions

- **Filtering Mechanism**: Assumed that the filtering functionality should be simple and intuitive using three buttons for predefined categories.
- **Networking**: Decided to use URLSession for its lightweight and native integration with iOS.
- **Image Handling**: Implemented manual caching for improved performance without external dependencies.
- **UI Framework**: Used UIKit for flexibility in creating the app's user interface and navigation flow.
- **API Data Format**: Assumed that the API returns JSON-formatted data; parsing was implemented accordingly.
- **Design Approach**: Followed the design shown in the provided screenshots as closely as possible without access to design files such as XD or Figma.

---

## Challenges and Solutions

### Challenge: Implementing Unit Testing

- **Problem**: Writing comprehensive unit tests to ensure code reliability and maintainability.
- **Solution**: Utilized XCTest framework to create unit tests for critical components like data models, view controllers, and network requests. Encountered challenges in testing asynchronous operations and dependencies, which were addressed by using XCTest's expectation mechanisms and dependency injection.

### Challenge: Dynamic Layouts for Multiple Screen Sizes
- **Problem**: Designing a layout that adapts to various iPhone models.
- **Solution**: Utilized UIKit’s `Auto Layout` constraints to ensure proper scaling and alignment.

### Challenge: Handling Network Errors
- **Problem**: Ensuring the app handles network failures gracefully.
- **Solution**: Implemented error handling with URLSession by checking error codes and providing user-friendly error messages.

### Challenge: Managing Image Performance Without Third-Party Libraries
- **Problem**: Efficiently loading images from URLs and caching them without relying on third-party libraries.
- **Solution**: Implemented a custom solution using URLSession to asynchronously download images and `NSCache` for caching. This approach ensures images are not reloaded unnecessarily, improving performance and reducing network usage.

---

## Usage

1. Launch the app.
2. Browse the list of characters.
3. Use the filtering buttons to narrow down the list based on specific criteria.
4. Tap on a character to view more details.

---

For any inquiries or feedback, feel free to contact me through [LinkedIn](https://www.linkedin.com/in/sarahgamal-iosengineer/).
