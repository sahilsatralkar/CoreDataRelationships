//
//  DataController.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 25/03/22.
//

import Foundation
import CoreData
import SwiftUI


class DataController : ObservableObject {
    let container : NSPersistentCloudKitContainer
    
    init() {
        container = NSPersistentCloudKitContainer(name: "CoreDataRelationships")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal error loading Core Data stores \(error.localizedDescription)")
            }
        }
    }
    
    
    
    func createSampleData() {
        let viewContext = container.viewContext
        
        let school = School(context: viewContext)
        school.id = UUID()
        school.name = "Hogwarts School of Witchcraft and Wizardry"
        school.address = "Scottish Highlands, United Kingdom"
        school.date = Date()
        
        let principal = Principal(context: viewContext)
        principal.id = UUID()
        principal.name = "Albus Dumbledore"
        principal.date = Date()
        principal.age = 115
        principal.experience = 24
        principal.school = school
        
        
        let teacher1 = Teacher(context: viewContext)
        teacher1.id = UUID()
        teacher1.name = "Minerva McGonagall"
        teacher1.age = 55
        teacher1.experience = 13
        teacher1.date = Date()
        teacher1.principal = principal
        teacher1.school = school
        
        let teacher2 = Teacher(context: viewContext)
        teacher2.id = UUID()
        teacher2.name = "Severus Snape"
        teacher2.age = 45
        teacher2.experience = 12
        teacher2.date = Date()
        teacher2.principal = principal
        teacher2.school = school
        
        let teacher3 = Teacher(context: viewContext)
        teacher3.id = UUID()
        teacher3.name = "Pomona Sprout"
        teacher3.age = 45
        teacher3.experience = 12
        teacher3.date = Date()
        teacher3.principal = principal
        teacher3.school = school
        
        let teacher4 = Teacher(context: viewContext)
        teacher4.id = UUID()
        teacher4.name = "Rubeus Hagrid"
        teacher4.age = 42
        teacher4.experience = 11
        teacher4.date = Date()
        teacher4.principal = principal
        teacher4.school = school
        
        let teacher5 = Teacher(context: viewContext)
        teacher5.id = UUID()
        teacher5.name = "Gilderoy Lockhart"
        teacher5.age = 47
        teacher5.experience = 4
        teacher5.date = Date()
        teacher5.principal = principal
        teacher5.school = school
        
        let student1 = Student(context: viewContext)
        student1.id = UUID()
        student1.name = "Hermione Granger"
        student1.age = 12
        student1.standard = 4
        student1.date = Date()
        student1.school = school
        student1.principal = principal
        student1.teachers = [teacher1, teacher2, teacher3, teacher4, teacher5]
        
        let student2 = Student(context: viewContext)
        student2.id = UUID()
        student2.name = "Percy Weasley"
        student1.age = 14
        student1.standard = 6
        student1.date = Date()
        student1.school = school
        student1.principal = principal
        student1.teachers = [teacher1, teacher2, teacher3, teacher4, teacher5]
        
        
        let student3 = Student(context: viewContext)
        student3.id = UUID()
        student3.name = "Neville Longbottom"
        student3.age = 12
        student3.standard = 4
        student3.date = Date()
        student3.school = school
        student3.principal = principal
        student3.teachers = [teacher1, teacher2, teacher3, teacher4, teacher5]
        
        let student4 = Student(context: viewContext)
        student4.id = UUID()
        student4.name = "Harry Potter"
        student4.age = 12
        student4.standard = 4
        student4.date = Date()
        student4.school = school
        student4.principal = principal
        student4.teachers = [teacher1, teacher2, teacher3, teacher4, teacher5]
        
        let student5 = Student(context: viewContext)
        student5.id = UUID()
        student5.name = "Ginny Weasley"
        student5.age = 9
        student5.standard = 1
        student5.date = Date()
        student5.school = school
        student5.principal = principal
        student5.teachers = [teacher1, teacher2, teacher3, teacher4, teacher5]
        
        let student6 = Student(context: viewContext)
        student6.id = UUID()
        student6.name = "Draco Malfoy"
        student6.age = 12
        student6.standard = 4
        student6.date = Date()
        student6.school = school
        student6.principal = principal
        student6.teachers = [teacher1, teacher2, teacher3, teacher4, teacher5]
        
        let student7 = Student(context: viewContext)
        student7.id = UUID()
        student7.name = "Ron Weasley"
        student7.age = 12
        student7.standard = 4
        student7.date = Date()
        student7.school = school
        student7.principal = principal
        student7.teachers = [teacher1, teacher2, teacher3, teacher4, teacher5]
        
        let student8 = Student(context: viewContext)
        student8.id = UUID()
        student8.name = "Luna Lovegood"
        student8.age = 11
        student8.standard = 3
        student8.date = Date()
        student8.school = school
        student8.principal = principal
        student8.teachers = [teacher1, teacher2, teacher3, teacher4, teacher5]
        
        let student9 = Student(context: viewContext)
        student9.id = UUID()
        student9.name = "Cho Chang"
        student9.age = 13
        student9.standard = 5
        student9.date = Date()
        student9.school = school
        student9.principal = principal
        student9.teachers = [teacher1, teacher2, teacher3, teacher4, teacher5]
        
        let student10 = Student(context: viewContext)
        student10.id = UUID()
        student10.name = "Parvati Patil"
        student10.age = 11
        student10.standard = 2
        student10.date = Date()
        student10.school = school
        student10.principal = principal
        student10.teachers = [teacher1, teacher2, teacher3, teacher4, teacher5]
       
        
        do {
            try viewContext.save()
        }
        catch {
            fatalError("Unable to load sample data: \(error.localizedDescription)")
        }
    }
    
    
    func save() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            }
            catch {
                fatalError("Unable to save data: \(error.localizedDescription)")
            }
        }
    }
    
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    
    func deleteAll() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = School.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        _ = try? container.viewContext.execute(batchDeleteRequest)
        
    }
}
