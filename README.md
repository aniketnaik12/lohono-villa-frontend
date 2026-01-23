# Lohono – Frontend (Flutter Mobile App)

This repository contains the Flutter-based frontend for the Lohono villa listing and pricing assignment.

The app is designed as a **mobile-first experience**, focusing on layout, interaction patterns, and API integration rather than full production completeness.

---

## 🛠 Tech Stack

* Flutter (Material)
* Dart
* HTTP for API integration

---

## 📌 Features

### Listing Screen

* Mobile-first villa listing
* Sticky search summary
* Filter & sort entry points
* Result count
* Villa cards with:

  * Default villa image (static image URL)
  * Name & location
  * Rating & review count
  * Tags (e.g. Pet-friendly, Event-friendly)
  * Per-night pricing

### Filters & Sort

* Filter and sort implemented as **bottom-sheet UI entry points**
* Demonstrates UX flow and layout
* Backend filtering is intentionally not implemented

### Villa Detail / Quote Screen

* Image header
* Availability status
* Per-night price breakdown
* Subtotal, GST, and total pricing

---

## 🚀 Setup Instructions

### 1️⃣ Install Flutter dependencies

```bash
flutter pub get
```

### 2️⃣ Run the app

```bash
flutter run
```

You can run the app on:

* Chrome (Flutter Web)
* Windows desktop
* Android emulator

> When running on Flutter Web, the backend should be available at `http://localhost:3000`.

---

## 🔗 Backend Integration

The frontend integrates with the following backend APIs:

* `GET /v1/villas/availability`
* `GET /v1/villas/:id/quote`

The API base URL is selected dynamically based on the platform (web vs emulator).

---

## 🎨 UI & UX Decisions

* Clean, minimal, mobile-first layout
* Default villa image via static URL to maintain visual consistency without media handling
* Focus on hierarchy and spacing rather than heavy visuals
* UI-driven filters and sorting to align with assignment scope

---

## 🧠 Notes & Assumptions

* Filters and sorting demonstrate interaction patterns only
* No image gallery or media management is included
* Flutter Web debug builds may have slower initial load times

---

## 🤖 AI Usage

Details about AI-assisted development and decision-making are documented in `AI_USAGE.md`.

---

## ✅ Status

The frontend is complete and fully integrated with the backend APIs.
