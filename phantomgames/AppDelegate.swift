//
//  AppDelegate.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/17.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    // MARK: Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "FavouriteCoreDataModel")
           container.loadPersistentStores { description, error in
               if let error = error as NSError? {
                   fatalError("Unable to load persistent stores: \(error), \(error.userInfo)")
               }
           }
           return container
       }()
       
       // MARK: - Core Data Saving support
       
       func saveContext() {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   let nsError = error as NSError
                   fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
               }
           }
       }
}
