# 💊 Smart Medication Assistant for Seniors

A Flutter-based app designed to help elderly individuals take their medications on time with the help of reminders, visual confirmation, and real-time caregiver alerts. Built with Firebase for real-time data sync and notification support.

![Flutter](https://img.shields.io/badge/Made%20with-Flutter-blue.svg)
![Firebase](https://img.shields.io/badge/Backend-Firebase-yellow)
![Hackathon](https://img.shields.io/badge/Project-Hackathon%202025-green)

---

## 🧠 Project Overview

Elderly individuals often miss or take the wrong medication, which can lead to serious health risks. This app provides a simple interface to manage medication schedules, track compliance, and alert caregivers when necessary — all with accessibility and ease of use in mind.

---

## ✨ Key Features

- 📅 **Medication Scheduler** – Set medicine name, dose, time, and frequency
- 🔔 **Smart Reminders** – Text and voice notifications at the right time
- ✅ **Medication Tracking** – Users confirm doses taken or missed
- 📊 **Compliance Dashboard** – Shows adherence trends and logs
- 📤 **Caregiver Alerts** – Notifies caregivers if doses are missed
- 🗣️ **Text-to-Speech** – Voice reminders for enhanced accessibility
- 🧠 **(Optional)** AI Assistant for medication-related questions
- 📄 **PDF Reports** – Generate weekly/monthly logs

---

## 🧰 Tech Stack

| Layer      | Technology         |
|------------|--------------------|
| Frontend   | Flutter             |
| Backend    | Firebase Firestore, Firebase Auth |
| Notifications | flutter_local_notifications, Firebase Cloud Messaging |
| Voice      | flutter_tts         |
| State Mgmt | Provider / Riverpod |
| Charts     | fl_chart            |
| AI (Bonus) | Gemini / ChatGPT API |
| Alerts     | Twilio / EmailJS (optional) |

---

## 📁 Folder Structure

```bash
/lib
  ├── main.dart
  ├── screens/
  ├── services/
  ├── models/
  ├── widgets/
  ├── providers/
  └── utils/
