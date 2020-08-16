import HealthKit

class WorkoutDataStore {
    
    class func loadPrancerciseWorkouts(completion: @escaping (([HKWorkout]?, Error?) -> Swift.Void)){
        
        //1. Get all workouts with the "Other" activity type.
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .other)
        
        //2. Get all workouts that only came from this app.
        let sourcePredicate = HKQuery.predicateForObjects(from: HKSource.default())
        
        //3. Combine the predicates into a single predicate.
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [workoutPredicate,
                                                                           sourcePredicate])
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              ascending: true)
        
        let query = HKSampleQuery(sampleType: HKObjectType.workoutType(),
                                  predicate: compound,
                                  limit: 0,
                                  sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                                    
                                    DispatchQueue.main.async {
                                        
                                        //4. Cast the samples as HKWorkout
                                        guard let samples = samples as? [HKWorkout],
                                            error == nil else {
                                                completion(nil, error)
                                                return
                                        }
                                        
                                        completion(samples, nil)
                                    }
        }
        
        HKHealthStore().execute(query)
    }
    
    
    class func save(prancerciseWorkout: SWTWorkout,
                    completion: @escaping ((Bool, Error?) -> Swift.Void)) {
        
        //1. Setup the Calorie Quantity for total energy burned
        let calorieQuantity = HKQuantity(unit: HKUnit.kilocalorie(),
                                         doubleValue: prancerciseWorkout.totalEnergyBurned)
        
        //2. Build the workout using data from your Prancercise workout
        let workout = HKWorkout(activityType: .other,
                                start: prancerciseWorkout.start,
                                end: prancerciseWorkout.end,
                                duration: prancerciseWorkout.duration,
                                totalEnergyBurned: calorieQuantity,
                                totalDistance: nil,
                                device: HKDevice.local(),
                                metadata: nil)
        
        //3. Save your workout to HealthKit
        let healthStore = HKHealthStore()
        
        healthStore.save(workout) { (success, error) in
            completion(success, error)
        }
        
    }
    
}

