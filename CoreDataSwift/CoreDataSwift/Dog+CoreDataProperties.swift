//
//  Dog+CoreDataProperties.swift
//  CoreDataSwift
//
//  Created by zhangpei on 16/6/16.
//  Copyright © 2016年 ivan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Dog {

    @NSManaged var name: String?
    @NSManaged var sex: String?
    @NSManaged var age: String?

}
