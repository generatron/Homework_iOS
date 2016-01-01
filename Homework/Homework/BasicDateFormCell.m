//
//  BasicDateFormCell.m
//  
//
//  Created by Chappy Asel on 1/1/16.
//
//

#import "BasicDateFormCell.h"

NSString *const XLFormRowDescriptorTypeBasicDate = @"XLFormRowDescriptorTypeBasicDate";

@implementation BasicDateFormCell {
    NSDate *startDateNormal;
    NSDate *endDateNormal;
    NSMutableArray *dates;
}

@synthesize pickerView = _pickerView;
@synthesize inlineRowDescriptor = _inlineRowDescriptor;

+(void)load {
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([BasicDateFormCell class]) forKey:XLFormRowDescriptorTypeBasicDate];
}

// initialise all objects such as Arrays, UIControls etc...
-(void)configure {
    [super configure];
    [self.contentView addSubview:self.pickerView];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[pickerView]-0-|" options:0 metrics:0 views:@{@"pickerView" : self.pickerView}]];
}

// update cell when it about to be presented
-(void)update {
    [super update];
    BOOL isDisable = self.rowDescriptor.isDisabled;
    self.userInteractionEnabled = !isDisable;
    self.contentView.alpha = isDisable ? 0.5 : 1.0;
    startDateNormal = [self normalizedDateForDate:self.startDate];
    endDateNormal = [self normalizedDateForDate:self.endDate];
    [self loadWithProvidedDates];
    [self.pickerView reloadAllComponents];
    NSDate *selectedDate = self.rowDescriptor.value;
    int row = [selectedDate timeIntervalSinceDate:startDateNormal]/60.0/60.0/24.0;
    if (selectedDate) [self.pickerView selectRow:row inComponent:0 animated:YES];
}

#pragma mark - Properties

-(UIPickerView *)pickerView {
    if (_pickerView) return _pickerView;
    _pickerView = [UIPickerView autolayoutView];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    return _pickerView;
}

#pragma mark - public methods

- (void)loadWithProvidedDates {
    NSDate *currentDateNormal = [self normalizedDateForDate:[NSDate date]];
    NSDate *tempDate = startDateNormal;
    dates = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"eeee, MMM d"];
    while ([tempDate timeIntervalSinceReferenceDate] <= [endDateNormal timeIntervalSinceReferenceDate]) {
        NSString *dateString;
        if ([tempDate timeIntervalSinceReferenceDate] == [currentDateNormal timeIntervalSinceReferenceDate]) dateString = @"Today";
        else dateString = [dateFormatter stringFromDate:tempDate];
        [dates addObject: dateString];
        tempDate = [tempDate dateByAddingTimeInterval:60*60*24];
    }
}

#pragma mark - private methods

- (NSDate *)normalizedDateForDate: (NSDate *)date {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSCalendarUnit preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSDateComponents *components = [calendar components:preservedComponents fromDate:date];
    return [calendar dateFromComponents:components];
}

#pragma mark - picker view data source

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.inlineRowDescriptor) return dates.count;
    return dates.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel*)view;
    if (!label){
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
        label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.text = dates[row];
    return label;
}

#pragma mark - picker view delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.inlineRowDescriptor) {
        self.inlineRowDescriptor.value = [startDateNormal dateByAddingTimeInterval:60*60*24*row];
        [self.formViewController updateFormRow:self.inlineRowDescriptor];
    }
    else {
        [self becomeFirstResponder];
        self.rowDescriptor.value = [startDateNormal dateByAddingTimeInterval:60*60*24*row];
    }
}

#pragma mark - protocol

+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 140.0;
}

-(BOOL)formDescriptorCellCanBecomeFirstResponder {
    return (!self.rowDescriptor.isDisabled && (self.inlineRowDescriptor == nil));
}

-(BOOL)formDescriptorCellBecomeFirstResponder {
    return [self becomeFirstResponder];
}


-(BOOL)canResignFirstResponder {
    return YES;
}

-(BOOL)canBecomeFirstResponder {
    return [self formDescriptorCellCanBecomeFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
