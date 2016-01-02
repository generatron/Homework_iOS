//
//  CourseValueTransformer.m
//  Homework
//
//  Created by Chappy Asel on 1/1/16.
//  Copyright © 2016 CD. All rights reserved.
//

#import "CourseValueTransformer.h"
#import "HWCourse.h"

@implementation CourseValueTransformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
    if (!value) return @"None";
    HWCourse *course = (HWCourse *)value;
    return [NSString stringWithFormat:@"Period %d: %@", course.period.intValue, course.name];
}

@end
