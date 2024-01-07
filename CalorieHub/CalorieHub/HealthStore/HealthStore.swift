//
//  HealthManager.swift
//  CalorieHub
//
//  Created by Kein Li on 12/19/23.
//

import Foundation
import HealthKit
import Observation

// HKQuantityType, HKQuantity : values/type
// HKQuantitySample : the actual data point created to save to Health
// HKQuery : query object to be execuged by the health store instance

enum HealthErrors : Error {
    case healthDataNotAvailable
    case authorization
}

@Observable
class HealthStore {
    
    var healthStore : HKHealthStore?
    var error : HealthErrors?
    var stepsTakenToday : Double?
    var caloriesBurnedToday : Double?
    
    init() {
        // Step 1 :
        // Check if it is available on this platform. If so, instantiate it
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        } else {
            // probably add this as an error msg ?
            error = HealthErrors.healthDataNotAvailable
            print("HealthKit is not available on this platform.")
        }
    }
    
    
 // need to set these up in the app's p.list - keys required for getting this to work. Per docs : You must set the usage keys, or your app will crash when you request authorization.
//    Customize the messages displayed on the permissions sheet by setting the following keys:
//    NSHealthShareUsageDescription customizes the message for reading data.
//    NSHealthUpdateUsageDescription customizes the message for writing data.
    
    
    
    func requestAuthHeightWeight() {
        // These return optionals so unwrap. Basically sets up the data we want to read/write
        
        //Since healthStore is also optional, we need to unwrap here as well
        guard let healthStore = self.healthStore else { return }
        
        guard let weight = HKQuantityType.quantityType(forIdentifier: .bodyMass) else { return }
        guard let height = HKQuantityType.quantityType(forIdentifier: .height) else { return }
        
        let types = Set([weight, height])
        
        healthStore.requestAuthorization(toShare: types , read: types) { (success, error) in
            if !success {
                print("error in authorization for height and weight")
            }
        }
    }
    
    func requestAuthStepsAndCaloriesBurned(){
        
        guard let healthStore = self.healthStore else { return }
        
        guard let steps = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        guard let caloriesBurned = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        
        let types = Set([steps,caloriesBurned])
                
        healthStore.requestAuthorization(toShare: types, read: types) { success, error in
            if !success {
                print("error in authorization")
            }
        }
    }
    
    
    // Mark: Method for saving the user's height and weight. Creates the HKQuantityType, checks for authorization status, and requests authorization to save
    
    // HKQuantityType : refers to the corresponding data type to read (i.e weight and height)
    func savingUserData(_ userWeight : Double?, _ userHeight : Double?) {
        
        // check healthstore and health types
        guard let healthStore = self.healthStore else { return }
        guard let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass) else{ return }
        guard let heightType = HKQuantityType.quantityType(forIdentifier: .height) else { return }
        
        guard let userWeight = userWeight else { return }
        guard let userHeight = userHeight else { return }
        
        // check authorization status first
        let statusWeight = healthStore.authorizationStatus(for: weightType)
        let statusHeight = healthStore.authorizationStatus(for: heightType)
        
        let types = Set([weightType, heightType])
        
        // this means user already approved, so just save it. called in editing
        if statusWeight.rawValue == 2 && statusHeight.rawValue == 2 {
            saveWeightSample(userWeight, weightType)
            saveHeightSample(userHeight, heightType)
        } else {
            
            // this means user has not approved, so request access first
            healthStore.requestAuthorization(toShare: types , read: types) { (success, error) in
                if success {
                    self.saveWeightSample(userWeight, weightType)
                    self.saveHeightSample(userHeight, heightType)
                } else {
                    print("error in authorization")
                }
            }
        }
    }
    
    // Mark: Helper method for the actual saving of the user's weight
    // Creates the HKQuantity and HKQuantitySample. When saving data
    // use HKSample subclasses (HKQuantitySample for example)
    // HKQuantity : Creates a HKQuantity type based on what we want to read
    // HKQuantitySample : Creates the acual sample data point, based on the provided HKQuantityType and HKQuantity amount
    
    func saveWeightSample(_ weight : Double, _ weightHKType : HKQuantityType){
        guard let healthStore = self.healthStore else { return }
        
        // create HK quantity objects
        let userWeightQuantity = HKQuantity(unit: .pound(), doubleValue: weight)
        
        // create a HKQuantitySample, which represents the data point to be saved
        let userWeightSample = HKQuantitySample(type: weightHKType, quantity: userWeightQuantity, start: Date(), end: Date())
        
        // call the save method
        healthStore.save(userWeightSample) { success,error in
            if success {
                print("Saved user weight")
            } else {
                print("Failed to save user weight")
            }
        }
    }
    
    func saveHeightSample(_ height : Double, _ heightHKType : HKQuantityType){
        guard let healthStore = self.healthStore else { return }
        // create HK quantity objects
        let userHeightQuantity = HKQuantity(unit: .inch(), doubleValue: height)
        
        // create a HKQuantitySample, which represents the data to be saved
        let userHeightSample = HKQuantitySample(type: heightHKType, quantity: userHeightQuantity, start: Date(), end: Date())
        
        // call the save method
        healthStore.save(userHeightSample) { success,error in
            if success {
                print("Saved user height")
            } else {
                print("Failed to save user height")
            }
        }
    }
    
    
    // Mark : Query the activity calories burned
    // HKSampleQuery : Requires the HKQuantityType to query. HKSampleQuery's
    // first parameter is HKSampleType, which is an abstract superclass that
    // HKQuantityType inherits from. This is why we can provide the code below
    func readTodaysActivity(){
        
        guard let healthStore = self.healthStore else { return }
        guard let activeEnergyBurnedType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        // HKSampleQuery's result handler : query itself, the resulted objects, and an error
        // The resultsHandler closure is executed by healthStore once .execute is
        // called, with the results in results
        
        let queryOne  = HKSampleQuery(sampleType: activeEnergyBurnedType, predicate: nil, limit: 0, sortDescriptors: nil, resultsHandler: { query, results, error in
            
            // attempts to cast results to HKQuantityType because
            // the returned type is [HKSample]? , and HKSample is abstract class
            // and we want HKQuantitySample types
            
            // Per apple docs, in iOS13+, HKQuantitySample is actually an
            // abstract superclass. The result will be one of  HKCumulativeQuantitySample and HKDiscreteQuantitySample subclasses
            // That is why when we print type(of:), we get HKCumulativeQuantitySample
            guard let samples = results as? [HKQuantitySample] else {
                print("error in casting")
                return
            }
            
            // update the results
            for sample in samples {
                self.caloriesBurnedToday = self.caloriesBurnedToday ?? 0 +  sample.quantity.doubleValue(for: .largeCalorie())
//                print("hello i am \(type(of: sample))")
//                print(sample.quantityType)
//                print(sample.count)
            }
        })
        
        
        let queryTwo = HKSampleQuery(sampleType: stepQuantityType, predicate: nil, limit: 0, sortDescriptors: nil, resultsHandler: { query, results, error in
            
                
            guard let samples = results as? [HKQuantitySample] else {
                print("error in casting")
                return
            }
            
            for sample in samples {
                self.stepsTakenToday = self.stepsTakenToday ?? 0 + sample.quantity.doubleValue(for: .count())
            }
        })
        
        healthStore.execute(queryOne)
        healthStore.execute(queryTwo)
    }
    
    
    
}


