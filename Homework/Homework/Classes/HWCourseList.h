//
//  HWCourseList.h
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "HWCourse.h"

@class HWCourse;

NS_ASSUME_NONNULL_BEGIN

@interface HWCourseList : NSManagedObject

+ (HWCourseList *) fetchCurrentCourseList;

- (void) save;

@end

NS_ASSUME_NONNULL_END

#import "HWCourseList+CoreDataProperties.h"
