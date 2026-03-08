# Blog Project - React + Vite + TypeScript + PostgreSQL + Flutter

A comprehensive full-stack blog application with a modern React frontend, Node.js backend with PostgreSQL database, and a Flutter Android mobile client.

## 🚀 Technologies Used

### Frontend (React + Vite + TypeScript)
- **Framework**: React 19.2.0
- **Build Tool**: Vite 7.3.1
- **Language**: TypeScript 5.9.3
- **Styling**: Tailwind CSS 4.2.1
- **Routing**: React Router DOM 7.13.1
- **HTTP Client**: Axios 1.13.6
- **Linting**: ESLint with TypeScript support

### Backend (Node.js + Express + PostgreSQL)
- **Runtime**: Node.js
- **Framework**: Express 5.2.1
- **Database**: PostgreSQL 8.20.0
- **Authentication**: JWT (jsonwebtoken 9.0.3)
- **Password Hashing**: bcryptjs 3.0.3
- **File Upload**: Multer 2.1.1 + Cloudinary 2.9.0
- **CORS**: cors 2.8.6
- **Environment**: dotenv 17.3.1

### Mobile App (Flutter + Dart)
- **Framework**: Flutter 3.11+
- **State Management**: Provider
- **HTTP Client**: http package
- **Image Handling**: image_picker, file_picker
- **Local Storage**: shared_preferences
- **Date Formatting**: intl package

## 📁 Project Structure

```
BlogProjectReactViteTypeScript/
├── client/                    # React frontend application
│   ├── src/
│   │   ├── components/        # Reusable UI components
│   │   ├── pages/            # Page components
│   │   ├── layouts/          # Layout components
│   │   ├── services/         # API service layer
│   │   └── App.tsx           # Main application component
│   ├── package.json          # Frontend dependencies
│   └── vite.config.ts        # Vite configuration
├── server/                   # Node.js backend API
│   ├── src/
│   │   ├── controllers/      # Route controllers
│   │   ├── middleware/       # Custom middleware
│   │   ├── routes/           # API route definitions
│   │   ├── config/           # Configuration files
│   │   └── server.ts         # Server entry point
│   ├── package.json          # Backend dependencies
│   └── tsconfig.json         # TypeScript configuration
├── BlogProjectFlutter/       # Flutter Android application
│   └── blog_project/         # Flutter project
│       ├── lib/
│       │   ├── models/       # Data models
│       │   ├── services/     # API services
│       │   ├── providers/    # State management
│       │   └── pages/        # Screen components
│       └── pubspec.yaml      # Flutter dependencies
└── README.md                 # This file
```

## 🛠️ Features Implemented

### Admin Dashboard (React)
- **Authentication**: Secure JWT-based login system
- **User Management**: Create and delete admin users
- **Blog Management**: Full CRUD operations for blog posts
- **Image Upload**: Gallery image picker and upload functionality
- **Responsive Design**: Mobile-friendly interface using Tailwind CSS

### Public Blog (React)
- **Home Page**: Browse all blog posts with title, content preview, and publication date
- **Post Details**: View complete blog post with images and full content
- **Blog List**: Paginated list of all posts with search functionality

### Mobile App (Flutter)
- **Home Page**: Browse all blog posts
- **Post Details**: View complete blog post details
- **Login Page**: Admin authentication
- **Admin Dashboard**: Full admin functionality
- **Blog Management**: Create, view, edit, and delete blog posts
- **User Management**: Create and delete admin users

## 🚀 Getting Started

### Prerequisites
- Node.js (latest version)
- PostgreSQL database
- Flutter SDK (for mobile app)
- Android Studio or VS Code with Flutter extension

### Backend Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/polymak/BlogProjectReactViteTypeScript.git
   cd BlogProjectReactViteTypeScript
   ```

2. **Install backend dependencies**
   ```bash
   cd server
   npm install
   ```

3. **Set up environment variables**
   Create a `.env` file in the `server` directory:
   ```
   PORT=3000
   DATABASE_URL="postgresql://username:password@localhost:5432/blog_db"
   JWT_SECRET="your_jwt_secret_key"
   CLOUDINARY_CLOUD_NAME="your_cloudinary_cloud_name"
   CLOUDINARY_API_KEY="your_cloudinary_api_key"
   CLOUDINARY_API_SECRET="your_cloudinary_api_secret"
   ```

4. **Initialize database**
   ```bash
   npm run build
   node dist/config/initDb.js
   ```

5. **Start the backend server**
   ```bash
   npm run dev
   ```

### Frontend Setup

1. **Install frontend dependencies**
   ```bash
   cd client
   npm install
   ```

2. **Start the development server**
   ```bash
   npm run dev
   ```

3. **Open your browser** and navigate to `http://localhost:5173`

### Mobile App Setup

1. **Navigate to Flutter project**
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

## 🔧 API Endpoints

### Authentication
- `POST /api/auth/login` - Admin login
- `POST /api/auth/register` - Create new admin user

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

## 📱 Screenshots

The application provides a clean, modern interface with:
- Material Design components for React frontend
- Responsive layouts that work on all devices
- Professional color scheme and typography
- Intuitive navigation and user experience

## 🔐 Security Features

- JWT-based authentication
- Password hashing with bcrypt
- CORS configuration for cross-origin requests
- Input validation and sanitization
- Secure file upload with Cloudinary

## 🚀 Deployment

### Backend Deployment
The backend is configured to deploy on Render with PostgreSQL database integration.

### Frontend Deployment
The React frontend can be built and deployed to any static hosting service:
```bash
npm run build
```

### Mobile App Deployment
The Flutter app can be built for Android and published to Google Play Store:
```bash
flutter build apk
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- React and Vite for the modern frontend development experience
- Express.js for the robust backend framework
- PostgreSQL for reliable database management
- Flutter for cross-platform mobile development
- Cloudinary for image storage and management
- All the amazing open-source packages that make this project possible

## 📞 Support

For issues and questions:
1. Check the API documentation
2. Verify environment configuration
3. Review console logs for error details
4. Ensure proper database connection
5. Check network connectivity for mobile app

---

**Note**: This project demonstrates a complete full-stack application with modern technologies and best practices. It serves as a template for building similar blog or content management applications.