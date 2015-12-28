//
//  HWAssessment+CoreDataProperties.h
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HWAssessment.h"

NS_ASSUME_NONNULL_BEGIN

@class HWCourse;

typedef enum {
    HWAssessmentTypeTest = 0,
    HWAssessmentTypeQuiz = 1,
    HWAssessmentTypePresentation = 2,
    HWAssessmentTypeOther = 3
} HWAssessmentType;

@interface HWAssessment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSDate *dateAssigned;
@property (nullable, nonatomic, retain) NSDate *dateDue;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) HWCourse *course;

@end

NS_ASSUME_NONNULL_END
