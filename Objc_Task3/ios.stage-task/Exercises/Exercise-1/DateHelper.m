#import "DateHelper.h"
#import "NSDate+CustomDate.h"

@implementation DateHelper

static NSDateFormatter *dateFormatter = nil;
static NSCalendar *calendar = nil;

+ (NSDateFormatter *)sharedDateFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
    });
    return dateFormatter;
}

+ (NSCalendar *)sharedCalendar {
    static dispatch_once_t calendarOnceToken;
    dispatch_once(&calendarOnceToken, ^{
        calendar = [NSCalendar currentCalendar];
    });
    return calendar;
}

#pragma mark - First

- (NSString *)monthNameBy:(NSUInteger)monthNumber {
    if (monthNumber < 1 || monthNumber > 12) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [DateHelper sharedDateFormatter];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_EN"]];

    NSDateComponents *components = [NSDateComponents new];
    [components setMonth:monthNumber];

    NSDate *date = [[DateHelper sharedCalendar] dateFromComponents:components];

    dateFormatter.dateFormat = @"MMMM";

    NSString *monthName = [dateFormatter stringFromDate:date];

    return monthName;
}

#pragma mark - Second

- (long)dayFromDate:(NSString *)date {
    if (date.length == 0) {
        return 0;
    }
    NSDateFormatter *dateFormatter = [DateHelper sharedDateFormatter];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";

    NSDate *dateObject = [dateFormatter dateFromString:date];

    if (!dateObject) {
        return 0;
    }

    NSDateComponents *components = [
        [DateHelper sharedCalendar] components:NSCalendarUnitDay fromDate:dateObject
    ];

    return components.day;
}

#pragma mark - Third

- (NSString *)getDayName:(NSDate*) date {
    if (!date) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [DateHelper sharedDateFormatter];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
    dateFormatter.dateFormat = @"EEE";

    NSString *dayName = [dateFormatter stringFromDate:date];

    return dayName;
}

#pragma mark - Fourth

- (BOOL)isDateInThisWeek:(NSDate *)date {
    if (!date) {
        return NO;
    }

    NSDate *currentDate = [NSDate date];

    NSDateComponents *currentWeekComponents = [
        [DateHelper sharedCalendar] components:(NSCalendarUnitYear | NSCalendarUnitWeekOfYear) fromDate:currentDate
    ];

    NSDateComponents *dateWeekComponents = [
        [DateHelper sharedCalendar] components:(NSCalendarUnitYear | NSCalendarUnitWeekOfYear) fromDate:date
    ];

    return (currentWeekComponents.year == dateWeekComponents.year) && 
    (currentWeekComponents.weekOfYear == dateWeekComponents.weekOfYear);
}

@end
