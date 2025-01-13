# Assignment1_masadiApp

A simple **Electronic Health Record (EHR)** application built using **Swift** and **SwiftUI** to explore the basics of iOS development. This app allows users to create and manage patient records, prescribe medications, and determine blood type compatibility.

---

## Features
1. **Patient Management**:
   - Add new patients with details like name, date of birth, height, weight, and optional blood type.
   - Auto-generate unique Medical Record Numbers (MRN) for each patient.

2. **Medication Management**:
   - View a list of current medications for each patient, sorted by date prescribed.
   - Prescribe new medications while avoiding duplicates for active medications.
   - Automatically determine if a medication is completed based on the prescription duration.

3. **Blood Type Compatibility**:
   - Determine which blood types a patient can receive blood from using the `BloodType` enum.

4. **CustomStringConvertible Support**:
   - Human-readable descriptions for medications and patients, making it easier to display them in the app.

5. **Unit Testing**:
   - Comprehensive unit tests are included for the `BloodType`, `Medication`, and `Patient` types to ensure robust functionality.

---

## Project Structure
```plaintext
Assignment1_masadiApp/
│
├── Assignment1_masadiApp/
│   ├── BloodType.swift       # Enum for blood types with compatibility logic
│   ├── Medication.swift      # Struct for medications with completion logic
│   ├── Patient.swift         # Class for managing patient data and methods
│   ├── ContentView.swift     # SwiftUI UI for creating and managing patients
│
├── Assignment1_masadiTests/
│   ├── BloodTypeTests.swift  # Unit tests for BloodType functionality
│   ├── MedicationTests.swift # Unit tests for Medication logic
│   ├── PatientTests.swift    # Unit tests for Patient logic and methods
│
└── README.md                 # Project description
