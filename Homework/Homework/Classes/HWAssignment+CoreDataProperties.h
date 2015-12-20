//
//  HWAssignment+CoreDataProperties.h
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HWAssignment.h"
#import "HWCourse.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWAssignment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateAssigned;
@property (nullable, nonatomic, retain) NSDate *dateDue;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *isCompleted;
@property (nullable, nonatomic, retain) HWCourse *course;

@end

NS_ASSUME_NONNULL_END
