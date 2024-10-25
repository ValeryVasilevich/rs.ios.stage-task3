#import "PlayersSeparator.h"

@implementation PlayersSeparator

- (NSInteger)dividePlayersIntoTeams:(NSArray<NSNumber *>*)ratingArray {
    NSInteger count = 0;
    NSInteger n = ratingArray.count;

    for (NSInteger i = 0; i < n - 2; i++) {
        for (NSInteger j = i + 1; j < n - 1; j++) {
            for (NSInteger k = j + 1; k < n; k++) {
                NSInteger ratingI = [ratingArray[i] integerValue];
                NSInteger ratingJ = [ratingArray[j] integerValue];
                NSInteger ratingK = [ratingArray[k] integerValue];

                if ((ratingI < ratingJ && ratingJ < ratingK) || (ratingI > ratingJ && ratingJ > ratingK)) {
                    count++;
                }
            }
        }
    }

    return count;
}

@end
