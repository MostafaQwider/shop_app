![image1(3)](https://github.com/user-attachments/assets/c5efccb7-c72b-4e2d-80c9-5a8ee071a05f)![image5(2)](https://github.com/user-attachments/assets/de4232e7-564d-4ff1-99f7-ffd0fe5fe8b6)![image1(3)](https://github.com/user-attachments/assets/c30762b6-26f1-4aa4-94f6-9dd44f30cf98)# Shop App - Flutter E-commerce Application

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

## 📱 App Screenshot

![image1](https://github.com/user-attachments/assets/d0acafd3-d282-4d7a-ac8a-86f82a14903a)

![image2](https://github.com/user-attachments/assets/830c92bc-88bc-4e0d-91d6-fbaab73ac3ef)

![image3](https://github.com/user-attachments/assets/d1c4c2a2-6f1a-47f1-bcf3-b6e9dcd7ca0d)

![image4](https://github.com/user-attachments/assets/77d2f456-c349-4fe6-a636-78c3ed816de9)

![image5](https://github.com/user-attachments/assets/4d5b92bb-7e77-4cde-ad6a-92375fc8164e)

![image1(1)](https://github.com/user-attachments/assets/803447da-4ecf-4567-9548-eb921a490455)

![image2(1)](https://github.com/user-attachments/assets/f1ad93fa-50f3-4578-80a0-1c69af97d4a8)

![image3(1)](https://github.com/user-attachments/assets/5d40d68e-d5e0-41fa-8da5-d67883aa1550)

![image4(1)](https://github.com/user-attachments/assets/f96d91e9-ba6e-4030-8d28-8676ee897e7d)

![image5(1)](https://github.com/user-attachments/assets/00ee3b4b-4fb4-49e7-bd12-72eda2579bfa)







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



