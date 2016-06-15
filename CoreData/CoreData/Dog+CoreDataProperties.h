//
//  Dog+CoreDataProperties.h
//  CoreData
//
//  Created by zhangpei on 16/6/15.
//  Copyright © 2016年 ivan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Dog.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dog (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *age;
@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
