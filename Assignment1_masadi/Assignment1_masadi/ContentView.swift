//
//  ContentView.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/12/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bloodType: BloodType? = nil
    @State private var newMedicationName: String = ""
    @State private var newMedicationDose: String = ""
    @State private var newMedicationRoute: String = ""
    @State private var newMedicationFrequency: String = ""
    @State private var newMedicationDuration: String = ""
    
    @State private var patient: Patient? = nil
    @State private var errorMessage: String? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Create a New Patient")
                        .font(.title2)
                        .bold()
                    
                    Group {
                        TextField("First Name", text: $firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Last Name", text: $lastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        
                        TextField("Height (cm)", text: $height)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Weight (kg)", text: $weight)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Picker("Blood Type", selection: $bloodType) {
                            Text("Unknown").tag(BloodType?.none)
                            ForEach(BloodType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type as BloodType?)
                            }
                        }
                    }
                    
                    Button("Create Patient") {
                        createPatient()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    if let patient = patient {
                        Divider()
                        
                        Text("Patient Information")
                            .font(.headline)
                        
                        Text(patient.fullNameWithAge())
                        Text("Height: \(patient.height, specifier: "%.1f") cm")
                        Text("Weight: \(patient.weight, specifier: "%.1f") kg")
                        if let bloodType = patient.bloodType {
                            Text("Blood Type: \(bloodType.rawValue)")
                        } else {
                            Text("Blood Type: Unknown")
                        }
                        
                        Divider()
                        
                        Text("Prescribe Medication")
                            .font(.headline)
                        
                        TextField("Medication Name", text: $newMedicationName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Dose (e.g., 500mg)", text: $newMedicationDose)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Route (e.g., oral)", text: $newMedicationRoute)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Frequency (times per day)", text: $newMedicationFrequency)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Duration (days)", text: $newMedicationDuration)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Prescribe Medication") {
                            prescribeMedication()
                        }
                        .buttonStyle(.borderedProminent)
                        
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        Divider()
                        
                        Text("Current Medications")
                            .font(.headline)
                        
                        if patient.currentMedications().isEmpty {
                            Text("No active medications.")
                        } else {
                            ForEach(patient.currentMedications(), id: \.datePrescribed) { medication in
                                Text(medication.description)
                            }
                        }
                        
                        Divider()
                        
                        if let compatibleDonors = patient.compatibleDonorBloodTypes() {
                            Text("Compatible Donor Blood Types")
                                .font(.headline)
                            
                            Text(compatibleDonors.map { $0.rawValue }.joined(separator: ", "))
                        } else {
                            Text("Blood Type Unknown - Cannot Determine Donors")
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("EHR App")
        }
    }
    
    // MARK: - Helper Methods
    
    private func createPatient() {
        guard let height = Double(height),
              let weight = Double(weight) else {
            errorMessage = "Height and weight must be numeric values."
            return
        }
        
        patient = Patient(
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            height: height,
            weight: weight,
            bloodType: bloodType
        )
        
        // Clear error message and input fields
        errorMessage = nil
    }
    
    private func prescribeMedication() {
        guard let patient = patient else { return }
        
        guard let frequency = Int(newMedicationFrequency),
              let duration = Int(newMedicationDuration) else {
            errorMessage = "Frequency and duration must be numeric values."
            return
        }
        
        let newMedication = Medication(
            datePrescribed: Date(),
            name: newMedicationName,
            dose: newMedicationDose,
            route: newMedicationRoute,
            frequency: frequency,
            duration: duration
        )
        
        do {
            try patient.prescribeMedication(newMedication)
            errorMessage = nil // Clear error message
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}


#Preview {
    ContentView()
}
