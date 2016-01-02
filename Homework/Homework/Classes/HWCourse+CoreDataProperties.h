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
@property (nullable, nonatomic, retain) UIColor *color;
@property (nullable, nonatomic, retain) NSOrderedSet<HWAssignment *> *assignments;
@property (nullable, nonatomic, retain) NSOrderedSet<HWAssessment *> *assessments;
@property (nullable, nonatomic, retain) NSManagedObject *courseList;

@end

@interface HWCourse (CoreDataGeneratedAccessors)

- (void)insertObject:(HWAssessment *)value inAssessmentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAssessmentsAtIndex:(NSUInteger)idx;
- (void)insertAssessments:(NSArray<HWAssessment *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAssessmentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAssessmentsAtIndex:(NSUInteger)idx withObject:(HWAssessment *)value;
- (void)replaceAssessmentsAtIndexes:(NSIndexSet *)indexes withAssessments:(NSArray<HWAssessment *> *)values;
- (void)addAssessmentsObject:(HWAssessment *)value;
- (void)removeAssessmentsObject:(HWAssessment *)value;
- (void)addAssessments:(NSOrderedSet<HWAssessment *> *)values;
- (void)removeAssessments:(NSOrderedSet<HWAssessment *> *)values;

- (void)insertObject:(HWAssignment *)value inAssignmentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAssignmentsAtIndex:(NSUInteger)idx;
- (void)insertAssignments:(NSArray<HWAssignment *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAssignmentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAssignmentsAtIndex:(NSUInteger)idx withObject:(HWAssignment *)value;
- (void)replaceAssignmentsAtIndexes:(NSIndexSet *)indexes withAssignments:(NSArray<HWAssignment *> *)values;
- (void)addAssignmentsObject:(HWAssignment *)value;
- (void)removeAssignmentsObject:(HWAssignment *)value;
- (void)addAssignments:(NSOrderedSet<HWAssignment *> *)values;
- (void)removeAssignments:(NSOrderedSet<HWAssignment *> *)values;

@end

NS_ASSUME_NONNULL_END
