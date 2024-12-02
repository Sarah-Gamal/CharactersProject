
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
- **Alamofire**: A popular Swift-based networking library used for API calls, enabling efficient and streamlined handling of HTTP requests and JSON parsing.
- **Kingfisher**: A lightweight library for downloading and caching images efficiently.
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

2. **Open the project in Xcode**:
   ```bash
   open CharactersProject.xcodeproj
   ```

3. **Install dependencies** (via CocoaPods):
   - Ensure Alamofire and Kingfisher are properly set up as dependencies.
   - For CocoaPods:
     ```bash
     pod install
     ```
     Then open the `.xcworkspace` file instead:
     ```bash
     open CharactersProject.xcworkspace
     ```

4. **Build and run the project**:
   - Select a simulator or connected device in Xcode.
   - Press `Cmd + R` to build and run the application.

---

## Assumptions and Decisions

- **Filtering Mechanism**: Assumed that the filtering functionality should be simple and intuitive using three buttons for predefined categories.
- **Networking**: Decided to use Alamofire for its ease of use and robust handling of HTTP requests.
- **Image Handling**: Chose Kingfisher for its efficient handling of image downloading and caching.
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
- **Solution**: Implemented error handling using Alamofire's built-in response validators and provided user-friendly error messages.

### Challenge: Managing Image Performance
- **Problem**: Efficiently handling large numbers of character images.
- **Solution**: Leveraged Kingfisher to asynchronously download and cache images, improving performance and user experience.

---

## Usage

1. Launch the app.
2. Browse the list of characters.
3. Use the filtering buttons to narrow down the list based on specific criteria.
4. Tap on a character to view more details.

---

For any inquiries or feedback, feel free to contact me through [LinkedIn](https://www.linkedin.com/in/sarahgamal-iosengineer/).
