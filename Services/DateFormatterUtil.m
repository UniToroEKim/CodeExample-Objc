//
//  DateFormatterUtil.m
//  CodeExample-Objc
//
//  Created by Edward Kim on 2/19/24.
//

#import "DateFormatterUtil.h"

@implementation DateFormatterUtil {
	NSDateFormatter *formatter;
}

+ (DateFormatterUtil *)sharedUtil {
	static DateFormatterUtil *sharedUtil = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedUtil = [[self alloc] init];
	});
	return sharedUtil;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"EEEE, MMMM d, yyyy hh:mm a";
	}
	return self;
}

- (NSString *)longString:(NSDate *)date {
	formatter.dateFormat = @"EEEE, MMMM d, yyyy hh:mm a";
	return [formatter stringFromDate:date];
}

- (NSString *)mediumString:(NSDate *)date {
	formatter.dateFormat = @"MMM d, yyyy hh:mm a";
	return [formatter stringFromDate:date];
}

- (NSString *)shortString:(NSDate *)date {
	formatter.dateFormat = @"EEE, MMM d";
	return [formatter stringFromDate:date];
}

- (NSString *)timeString:(NSDate *)date {
	formatter.dateFormat = @"hh:mm a";
	return [formatter stringFromDate:date];
}

@end
