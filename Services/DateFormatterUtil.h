//
//  DateFormatterUtil.h
//  CodeExample-Objc
//
//  Created by Edward Kim on 2/19/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateFormatterUtil : NSObject

+ (DateFormatterUtil *)sharedUtil;

- (NSString *)longString:(NSDate *)date;
- (NSString *)mediumString:(NSDate *)date;
- (NSString *)shortString:(NSDate *)date;
- (NSString *)timeString:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
