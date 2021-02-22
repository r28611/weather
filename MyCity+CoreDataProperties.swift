//
//  MyCity+CoreDataProperties.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 22.02.2021.
//
//

import Foundation
import CoreData


extension MyCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyCity> {
        return NSFetchRequest<MyCity>(entityName: "MyCity")
    }

    @NSManaged public var currentTemp: Double
    @NSManaged public var image: String?
    @NSManaged public var name: String

}

extension MyCity : Identifiable {

}
