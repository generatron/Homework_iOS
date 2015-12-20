//
//  HWCourse+CoreDataProperties.h
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HWCourse.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWCourse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *period;
@property (nullable, nonatomic, retain) NSSet<HWAssignment *> *assignments;
@property (nullable, nonatomic, retain) NSSet<HWAssessment *> *assesments;
@property (nullable, nonatomic, retain) NSManagedObject *courseList;

@end

@interface HWCourse (CoreDataGeneratedAccessors)

- (void)addAssignmentsObject:(HWAssignment *)value;
- (void)removeAssignmentsObject:(HWAssignment *)value;
- (void)addAssignments:(NSSet<HWAssignment *> *)values;
- (void)removeAssignments:(NSSet<HWAssignment *> *)values;

- (void)addAssesmentsObject:(HWAssessment *)value;
- (void)removeAssesmentsObject:(HWAssessment *)value;
- (void)addAssesments:(NSSet<HWAssessment *> *)values;
- (void)removeAssesments:(NSSet<HWAssessment *> *)values;

@end

NS_ASSUME_NONNULL_END
