//
//  Entity+CoreDataProperties.swift
//  MyPhotoList
//
//  Created by Macbook Air on 23.05.2022.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> { // Entity'i getirecek. Return tip olarak Entity'i dondurecek.
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    
    // These are Entities
    @NSManaged public var titletext: String?
    @NSManaged public var descriptiontext: String?
    @NSManaged public var image: Data?

}

extension Entity : Identifiable {

}
