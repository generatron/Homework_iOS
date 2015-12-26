//
//  HWCourseList+CoreDataProperties.h
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HWCourseList.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWCourseList (CoreDataProperties)

@property (nullable, nonatomic, retain) NSOrderedSet<HWCourse *> *courses;

@end

@interface HWCourseList (CoreDataGeneratedAccessors)

- (void)insertObject:(HWCourse *)value inCoursesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCoursesAtIndex:(NSUInteger)idx;
- (void)insertCourses:(NSArray<HWCourse *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCoursesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCoursesAtIndex:(NSUInteger)idx withObject:(HWCourse *)value;
- (void)replaceCoursesAtIndexes:(NSIndexSet *)indexes withCourses:(NSArray<HWCourse *> *)values;
- (void)addCoursesObject:(HWCourse *)value;
- (void)removeCoursesObject:(HWCourse *)value;
- (void)addCourses:(NSOrderedSet<HWCourse *> *)values;
- (void)removeCourses:(NSOrderedSet<HWCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
