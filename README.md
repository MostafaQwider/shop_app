# Shop App - Flutter E-commerce Application

**Shop App** is a Flutter e-commerce application built with **GetX**, designed for selling clothing. The app supports **three languages**: English, Arabic, and German, and includes a **full authentication system** (sign up, login, account verification, password reset, password change).

---

## 🛠️ Features

- Modern and user-friendly interface.  
- Manage products and detailed product info (description, colors, sizes, prices).  
- Shopping cart management and checkout process.  
- Multi-language support: English, Arabic, German.  
- Full authentication system:
  - User registration  
  - Login and email verification  
  - Password reset  
  - Change password  
- Uses **Clean Architecture** for separation of concerns:  
  - **domain**: business logic  
  - **data**: access data from API or local  
  - **presentation**: UI and GetX controllers  
- Uses **GetX** for state management, routing, and bindings.  
- Supports favorites, orders, wallets, and promocodes.  

---

## 🗂️ Project Structure

lib/
│

├── core/                        
│   ├── constants/               
│   ├── services/                
│   ├── styles/       
│   ├── translations/  
│   └── utils/                 
│
├── data/                         
│   ├── data_sources/            
│   ├── models/               
│   └── repositories/       
│
├── domain/                    
│   ├── entities/              
│   ├── repositories/           
│   └── use_cases/               
│
├── presentation/               
│   ├── bindings/              
│   ├── component/               
│   ├── controllers/            
│   ├── pages/                  
│   ├── routes/                 
│
└── main.dart   


## ⚡ Technologies Used

- **Flutter** for mobile development  
- **Dart** programming language  
- **GetX** for state management, routing, and bindings  
- **REST API** for backend communication  
- **Multi-language support** (English, Arabic, German)  

---

## 🚀 Running the Project

1. Make sure Flutter is installed on your machine.  
2. Clone the repository:
```
git clone https://github.com/MostafaQwider/shop_app.git
cd shop_app
```
3. Install dependencies:
```
flutter pub get
```
4. Run the app on a simulator or device:
```
flutter run
```
🔐 Authentication Notes

A verification code is sent via email during registration.

Supports password reset and change easily.

🌐 Supported Languages

English (en)

Arabic (ar)

German (de)



