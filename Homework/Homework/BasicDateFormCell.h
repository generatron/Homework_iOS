//
//  BasicDateFormCell.h
//  
//
//  Created by Chappy Asel on 1/1/16.
//
//

#import "XLForm.h"
#import "XLFormBaseCell.h"

extern NSString * const XLFormRowDescriptorTypeBasicDate;

@interface BasicDateFormCell : XLFormBaseCell <XLFormInlineRowDescriptorCell, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) UIPickerView *pickerView;

@property NSDate *startDate;
@property NSDate *endDate;

@end
