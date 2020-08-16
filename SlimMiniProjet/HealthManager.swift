//
//  HealthManager.swift
//  SlimMiniProjet
//
//  Created by Yafet Shil on 07/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//
import HealthKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class HealthManager {

    let kit = HKHealthStore()

    func checkAuth() -> Bool {
        var success = true
        if HKHealthStore.isHealthDataAvailable() {
            let stepCounter = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)
            kit.requestAuthorization(toShare: nil, read: stepCounter as? Set<HKObjectType>) { bool, error in
                success = bool
            }
        }
        else {
            return false
        }
        return success
    }

    func fetchStepCount(_ completionHandler: @escaping (Double, Bool) -> Void) {

        let today = Date()
        let previousDay = today.addingTimeInterval(TimeInterval(-82400))
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: previousDay, end: today, options: HKQueryOptions())
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) { _, results, error in
            var steps: Double = 0
            if results?.count > 0
            {
                for result in results as! [HKQuantitySample]
                {
                    steps += result.quantity.doubleValue(for: HKUnit.count())
                }
                completionHandler(steps, true)
            }
            else {
                completionHandler(steps, false)
            }
        }
        kit.execute(query)
    }

}

