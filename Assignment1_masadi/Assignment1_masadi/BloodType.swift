//
//  BloodType.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/12/25.
//

enum BloodType: String { // An enum containing all the possible blood types
    case Ap = "A+"
    case An = "A-"
    case Bp = "B+"
    case Bn = "B-"
    case ABp = "AB+"
    case ABn = "AB-"
    case Op = "O+"
    case On = "O-"
    
    func canReceive(from donor: BloodType) -> Bool { // A switch to determine if it can receive from a certain blood type.
        switch self {
        case .Ap:
            return donor == .Ap || donor == .An || donor == .Op || donor == .On
        case .An:
            return donor == .An || donor == .On
        case .Bp:
            return donor == .Bp || donor == .Bn || donor == .Op || donor == .On
        case .Bn:
            return donor == .Bn || donor == .On
        case .ABp:
            return true // AB+ is a universal recipient
        case .ABn:
            return donor == .ABn || donor == .An || donor == .Bn || donor == .On
        case .Op:
            return donor == .Op || donor == .On
        case .On:
            return donor == .On // O- is the universal donor, but can only receive from O-
        }
    }
    
    func compatibleDonors() -> [BloodType] { // Running all the blood types through canReceive as a filter to get an array of donors.
        BloodType.allCases.filter { self.canReceive(from: $0) }
    }
}

extension BloodType: CaseIterable {} // Using CaseIterable protocol to get all the blood types in an array.
// I specifically use it to get a list of all and determine the compatible donors in its func.
