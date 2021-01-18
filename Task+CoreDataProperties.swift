//
//  Task+CoreDataProperties.swift
//  todoApp
//
//  Created by a111 on 2020/12/15.
//  Copyright © 2020 a111. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var checked: Bool

}
