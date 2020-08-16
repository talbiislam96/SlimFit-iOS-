//
//  HKBiologicalSex+StringRepresentation.swift
//  SlimMiniProjet
//
//  Created by Yafet Shil on 29/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import HealthKit

extension HKBiologicalSex {
  
  var stringRepresentation: String {
    switch self {
    case .notSet: return "Unknown"
    case .female: return "Female"
    case .male: return "Male"
    case .other: return "Other"
    }
  }
}

