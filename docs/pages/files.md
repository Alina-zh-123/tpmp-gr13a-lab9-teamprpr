---
layout: default
---

# Диаграмма файлов приложения

## Диаграмма компонентов

<img width="1131" height="706" alt="image" src="https://github.com/user-attachments/assets/bfc8a45a-1f16-46a1-931b-1d028ae0042e" />

## Описание файлов 

### Проект структурирован согласно концепции MVC

```
lab9.xcodeproj //Настройки и рабочее пространство Xcode
│
lab9
│── Assets.xcassets  //Графические ресурсы
│   ├── AccentColor.colorset
│   ├── AppIcon.appiconset
│   └── logo_aurora.imageset
│
│── Base.lproj
│   └── LaunchScreen.storyboard //Базовый LaunchScreen.storyboard
│
│── Controller
│   └── AppNameApp.swift //Точка входа приложения (структура @main)
│
│── Model
│   ├── lab9.xcdatamodeld
│   │   ├── lab9.xcdatamodel //Модель CoreData (филиалы банка)
│   │   └── .xccurrentversion
│   └── Persistence.swift    //Инициализация CoreData, загрузка данных филиалов
│
│── Preview Content
│   └── Preview Assets.xcassets //Ресурсы для SwiftUI Preview
│
│── View //Экранная логика приложения
│   ├── AccountsListView.swift          //Список счетов
│   ├── BranchMapView.swift             //Карта отделений
│   ├── ContentView.swift               //Навигация между экранами
│   ├── CurrencyView.swift              //Курсы валют
│   ├── LoginView.swift                 //Авторизация
│   └── MainMenuView.swift              //Главное меню
│
│   //Локализация
│── en.lproj
│   └── Localizable.strings  //EN
│
│── it.lproj
│   ├── LaunchScreen.strings 
│   └── Localizable.strings //IT
│
│── ru-RU.lproj             //RU
│   └── Info.plist
```
