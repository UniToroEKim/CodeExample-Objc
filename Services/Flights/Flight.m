//
//  Flight.m
//  CodeExample-Objc
//
//  Created by Edward Kim on 2/19/24.
//

#import "Flight.h"
#import "DateFormatterUtil.h"

@implementation Flight

- (instancetype)initWithSnapshot:(FIRDocumentSnapshot *)snapshot {
	self = [super init];
	if (self) {
		_flightID = snapshot.documentID;
		_airline = snapshot.data[@"airline"];
		_number = snapshot.data[@"number"];
		_departureAirport = snapshot.data[@"departureAirport"];
		_arrivalAirport = snapshot.data[@"arrivalAirport"];
		_departureTime = [self dateFromTimestamp:snapshot.data[@"departureTime"]];
		_arrivalTime = [self dateFromTimestamp:snapshot.data[@"arrivalTime"]];
	}
	return self;
}

- (NSDate *)dateFromTimestamp:(FIRTimestamp *)timestamp {
	return [NSDate dateWithTimeIntervalSince1970:timestamp.seconds];
}

- (NSString *)formDepartureDate {
	return [[DateFormatterUtil sharedUtil] shortString:self.departureTime];
}

- (NSString *)formArrivalDate {
	return [[DateFormatterUtil sharedUtil] shortString:self.arrivalTime];
}

- (NSString *)formDepartureTime {
	return [[DateFormatterUtil sharedUtil] timeString:self.departureTime];
}

- (NSString *)formArrivalTime {
	return [[DateFormatterUtil sharedUtil] timeString:self.arrivalTime];
}

@end
