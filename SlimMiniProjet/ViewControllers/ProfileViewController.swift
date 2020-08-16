//
//  ProfileViewController.swift
//  SlimMiniProjet
//
//  Created by Yafet Shil on 29/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import HealthKit

class ProfileViewController: UITableViewController {
    
    
@IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var biologicalSexLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bodyMassIndexLabel: UILabel!
    
    private enum ProfileSection: Int {
       case ageSexBloodType
       case weightHeightBMI
       case readHealthKitData
       case saveBMI
     }
    private enum ProfileDataError: Error {
      
      case missingBodyMassIndex
      
      var localizedDescription: String {
        switch self {
        case .missingBodyMassIndex:
          return "Unable to calculate body mass index with available profile data."
        }
      }
    }
 
   private let userHealthProfile = UserHealthProfile()
    
    private func updateHealthInfo() {
      loadAndDisplayProfileInfo()
      loadAndDisplayMostRecentWeight()
      loadAndDisplayMostRecentHeight()
    }
    
    private func loadAndDisplayProfileInfo() {
      do {
          let profileInfo = try ProfileDataStore.getProfileInfo()
          userHealthProfile.age = profileInfo.age
          userHealthProfile.biologicalSex = profileInfo.biologicalSex
          updateLabels()
      } catch let error {
          self.displayAlert(for: error)
      }
    }
    
    private func updateLabels() {
      if let age = userHealthProfile.age {
          ageLabel.text = "\(age)"
      }
      
      if let biologicalSex = userHealthProfile.biologicalSex {
          biologicalSexLabel.text = biologicalSex.stringRepresentation
      }
      
      if let weight = userHealthProfile.weightInKilograms {
          let weightFormatter = MassFormatter()
          weightFormatter.isForPersonMassUse = true
          weightLabel.text = weightFormatter.string(fromKilograms: weight)
      }
      
      if let height = userHealthProfile.heightInMeters {
          let heightFormatter = LengthFormatter()
          heightFormatter.isForPersonHeightUse = true
          heightLabel.text = heightFormatter.string(fromMeters: height)
      }
      
      if let bodyMassIndex = userHealthProfile.bodyMassIndex {
          bodyMassIndexLabel.text = String(format: "%.02f", bodyMassIndex)
      }
    }
    
    private func loadAndDisplayMostRecentHeight() {
      //1. Use HealthKit to create the Height Sample Type
      guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
          print("Height Sample Type is no longer available in HealthKit")
          return
      }
      
      ProfileDataStore.getMostRecentSample(for: heightSampleType) { (sample, error) in
          
          guard let sample = sample else {
              
              if let error = error {
                  self.displayAlert(for: error)
              }
              
              return
          }
          
          //2. Convert the height sample to meters, save to the profile model,
          //   and update the user interface.
          let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
          self.userHealthProfile.heightInMeters = heightInMeters
          self.updateLabels()
      }
    }
    
    private func loadAndDisplayMostRecentWeight() {
      guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
          print("Body Mass Sample Type is no longer available in HealthKit")
          return
      }
      
      ProfileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
          
          guard let sample = sample else {
              
              if let error = error {
                  self.displayAlert(for: error)
              }
              return
          }
          
          let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
          self.userHealthProfile.weightInKilograms = weightInKilograms
          self.updateLabels()
      }
    }
    
    private func saveBodyMassIndexToHealthKit() {
      guard let bodyMassIndex = userHealthProfile.bodyMassIndex else {
          displayAlert(for: ProfileDataError.missingBodyMassIndex)
          return
      }
      
      ProfileDataStore.saveBodyMassIndexSample(bodyMassIndex: bodyMassIndex,
                                               date: Date())
    }
    
    private func displayAlert(for error: Error) {
      
      let alert = UIAlertController(title: nil,
                                    message: error.localizedDescription,
                                    preferredStyle: .alert)
      
      alert.addAction(UIAlertAction(title: "O.K.",
                                    style: .default,
                                    handler: nil))
      
      present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      guard let section = ProfileSection(rawValue: indexPath.section) else {
        fatalError("A ProfileSection should map to the index path's section")
      }
      
      switch section {
      case .saveBMI:
        saveBodyMassIndexToHealthKit()
      case .readHealthKitData:
        updateHealthInfo()
      default: break
      }
    }

}
