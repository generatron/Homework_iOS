//
//  HWCourseList+CoreDataProperties.m
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HWCourseList+CoreDataProperties.h"

@implementation HWCourseList (CoreDataProperties)

@dynamic courses;

- (void)addCoursesObject:(HWCourse *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.courses];
    [tempSet addObject:value];
    [tempSet sortUsingComparator:^NSComparisonResult(HWCourse  *c1, HWCourse *c2) {
        if (c1.period.intValue == c2.period.intValue) return NSOrderedSame;
        if (c1.period.intValue < c2.period.intValue) return NSOrderedAscending;
        return NSOrderedDescending;
    }];
    self.courses = tempSet;
}

- (void)removeObjectFromCoursesAtIndex:(NSUInteger)idx {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.courses];
    [tempSet removeObjectAtIndex:idx];
    self.courses = tempSet;
}

@end
