# Blog Project - Flutter Android Application

This is a Flutter Android application that replicates all the functionality from the original React/Vite/TypeScript blog project.

## Features

### 📱 User Interface
- **Home Page**: Browse all blog posts with title, content preview, and publication date
- **Post Details**: View complete blog post with images and full content
- **Login Page**: Admin authentication with username and password

### 🔐 Admin Dashboard
- **Authentication**: Secure login system with JWT tokens
- **User Management**: Create and delete admin users
- **Blog Management**: Full CRUD operations for blog posts including image upload

### 📝 Blog Management
- **Create Posts**: Add new blog posts with title, content, and images
- **View Posts**: Browse all posts with search and filtering
- **Update Posts**: Edit existing posts (UI ready, backend integration pending)
- **Delete Posts**: Remove posts with confirmation dialog
- **Image Upload**: Gallery image picker and upload functionality

### 👥 User Management
- **Create Admins**: Add new admin users with roles
- **View Admins**: List all admin users with creation dates
- **Delete Admins**: Remove admin users with confirmation

## Technology Stack

### Frontend (Flutter)
- **Framework**: Flutter 3.11+
- **State Management**: Provider
- **HTTP Client**: http package
- **Image Handling**: image_picker, file_picker
- **Local Storage**: shared_preferences
- **Date Formatting**: intl package

### Backend Integration
- **API Base URL**: https://blog-backend-kf3i.onrender.com
- **Authentication**: JWT tokens
- **Database**: PostgreSQL (managed by backend)
- **Image Storage**: Server uploads (managed by backend)

## Project Structure

```
lib/
├── models/
│   ├── admin.dart          # Admin user model
│   └── post.dart           # Blog post model
├── services/
│   ├── api_service.dart    # HTTP API client
│   └── image_upload_service.dart  # Image upload functionality
├── providers/
│   └── auth_provider.dart  # Authentication state management
├── pages/
│   ├── home_page.dart      # Public blog listing
│   ├── login_page.dart     # Admin login
│   ├── dashboard_page.dart # Admin dashboard
│   ├── blog_list_page.dart # Blog management
│   ├── users_list_page.dart # User management
│   └── post_details_page.dart # Post viewing
└── main.dart              # App entry point
```

## Installation

### Prerequisites
- Flutter SDK 3.11 or higher
- Android Studio or VS Code with Flutter extension
- Android device or emulator

### Setup Instructions

1. **Clone the project**
   ```bash
   cd BlogProjectFlutter/blog_project
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## Usage

### For Users
1. Open the app to view the home page with all blog posts
2. Tap any post to view full details
3. Navigate using the app bar

### For Admins
1. Go to the login page
2. Enter admin credentials (provided by system admin)
3. Access the dashboard to manage content

### Admin Features
- **Blog Management**: Create, view, edit, and delete blog posts
- **User Management**: Create and delete admin users
- **Image Upload**: Add images to blog posts via gallery picker

## API Endpoints Used

### Authentication
- `POST /api/auth/login` - Admin login

### Blog Posts
- `GET /api/posts` - Get all posts
- `GET /api/posts/:id` - Get single post
- `POST /api/posts` - Create new post
- `PUT /api/posts/:id` - Update post
- `DELETE /api/posts/:id` - Delete post

### Admin Users
- `GET /api/admins` - Get all admins
- `POST /api/admins` - Create new admin
- `DELETE /api/admins/:id` - Delete admin

## Screenshots

The application provides a clean, modern interface with:
- Material Design components
- Responsive layouts
- Intuitive navigation
- Professional color scheme

## Development Notes

### Image Upload
- Currently uses basic multipart form data
- Gallery image picker implemented
- Server-side upload endpoint integration ready

### State Management
- Provider pattern for authentication state
- Local storage for persistent login
- Clean separation of concerns

### Error Handling
- Network error handling
- User feedback with SnackBars
- Loading states for better UX

## Future Enhancements

- [ ] Implement post editing functionality
- [ ] Add image preview before upload
- [ ] Implement search and filtering
- [ ] Add offline support with caching
- [ ] Implement push notifications
- [ ] Add dark mode support

## Troubleshooting

### Common Issues
1. **Image Picker Not Working**: Ensure camera/gallery permissions are granted
2. **Network Errors**: Check internet connection and API endpoint availability
3. **Build Errors**: Run `flutter clean` and `flutter pub get`

### Development Mode
The app requires Developer Mode enabled on Windows for symlink support during development.

## License

This project is part of the BlogProjectReactViteTypeScript repository and follows the same licensing terms.

## Support

For issues and questions:
1. Check the backend API is running
2. Verify network connectivity
3. Review console logs for error details
4. Ensure proper permissions are granted