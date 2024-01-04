//
//  HealthManager.swift
//  CalorieHub
//
//  Created by Kein Li on 12/19/23.
//

import Foundation
import HealthKit
import Observation

// Add info about saving protein, carb, fats, and calories ( think this is dietary energy)(


enum HealthErrors : Error {
    case healthDataNotAvailable
    case authorization
}

@Observable
class HealthStore {
    
    var healthStore : HKHealthStore?
    var error : HealthErrors?
    var stepsGoal : Double = 0
    
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
    
    
    func requestAuthorization() {
        // These return optionals so unwrap. Basically sets up the data we want to read/write
        guard let stepCount = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        guard let caloriesBurned = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        guard let weight = HKQuantityType.quantityType(forIdentifier: .bodyMass) else { return }
        guard let height = HKQuantityType.quantityType(forIdentifier: .height) else { return }
        guard let walkingSpeed = HKQuantityType.quantityType(forIdentifier: .walkingSpeed) else { return }
        
        //Since healthStore is also optional, we need to unwrap here as well
        guard let healthStore = self.healthStore else { return }
        
        let allTypes = Set([stepCount, caloriesBurned, weight, height, walkingSpeed])
        
        healthStore.requestAuthorization(toShare: allTypes , read: allTypes) { (success, error) in
            if success {
            } else {
                print("error in authorization")
            }
        } // want to share and read everything
    }
    
    
    func requestAuthHeightWeight() {
        // These return optionals so unwrap. Basically sets up the data we want to read/write
        
        //Since healthStore is also optional, we need to unwrap here as well
        guard let healthStore = self.healthStore else { return }
        
        
        guard let weight = HKQuantityType.quantityType(forIdentifier: .bodyMass) else { return }
        guard let height = HKQuantityType.quantityType(forIdentifier: .height) else { return }
        
        
        let allTypes = Set([weight, height])
        
        healthStore.requestAuthorization(toShare: allTypes , read: allTypes) { (success, error) in
            if success {
                
            } else {
                print("error in authorization")
            }
        } // want to share and read everything
    }
    
    
    // Mark: Method for saving the user's height and weight. Creates the HKQuantityType, checks for authorization status, and requests authorization to save
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
        
        // this means user already approved, so just save it
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
    
    func saveWeightSample(_ weight : Double, _ weightHKType : HKQuantityType){
        guard let healthStore = self.healthStore else { return }
        // create HK quantity objects
        let userWeightQuantity = HKQuantity(unit: .pound(), doubleValue: weight)
        
        
        // create a HKQuantitySample, which represents the data to be saved
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
    
}


