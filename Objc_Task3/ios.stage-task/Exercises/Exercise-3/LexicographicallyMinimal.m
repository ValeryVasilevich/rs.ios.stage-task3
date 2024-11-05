#import "LexicographicallyMinimal.h"

@interface LexicographicallyMinimal()

@property (nonatomic, strong) NSMutableString *resultString;

@end

@implementation LexicographicallyMinimal

-(NSString *)findLexicographicallyMinimalForString1:(NSString *)string1 andString2:(NSString *)string2 {
    NSMutableString *mutableString1 = [string1 mutableCopy];
    NSMutableString *mutableString2 = [string2 mutableCopy];
    NSMutableString *result = [NSMutableString new];

    while (mutableString1.length > 0 && mutableString2.length > 0) {
        unichar char1 = [mutableString1 characterAtIndex:0];
        unichar char2 = [mutableString2 characterAtIndex:0];

        if (char1 <= char2) {
            [result appendFormat:@"%C", char1];
            [mutableString1 deleteCharactersInRange:NSMakeRange(0, 1)];
        } else {
            [result appendFormat:@"%C", char2];
            [mutableString2 deleteCharactersInRange:NSMakeRange(0, 1)];
        }
    }

    if (mutableString1.length > 0) {
        [result appendString:mutableString1];
    } else if (mutableString2.length > 0) {
        [result appendString:mutableString2];
    }

    return result;
}

@end
