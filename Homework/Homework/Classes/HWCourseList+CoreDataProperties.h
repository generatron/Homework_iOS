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

@property (nullable, nonatomic, retain) NSSet<HWCourse *> *courses;

@end

@interface HWCourseList (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(HWCourse *)value;
- (void)removeCoursesObject:(HWCourse *)value;
- (void)addCourses:(NSSet<HWCourse *> *)values;
- (void)removeCourses:(NSSet<HWCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
