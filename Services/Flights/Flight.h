//
//  Flight.h
//  CodeExample-Objc
//
//  Created by Edward Kim on 2/19/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@import Firebase;

@interface Flight : NSObject

@property (nonatomic, copy) NSString *flightID;
@property (nonatomic, copy) NSString *airline;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *departureAirport;
@property (nonatomic, copy) NSString *arrivalAirport;
@property (nonatomic, strong) NSDate *departureTime;
@property (nonatomic, strong) NSDate *arrivalTime;

- (instancetype)initWithSnapshot:(FIRDocumentSnapshot *)snapshot;
- (NSString *)formDepartureDate;
- (NSString *)formArrivalDate;
- (NSString *)formDepartureTime;
- (NSString *)formArrivalTime;
@end

NS_ASSUME_NONNULL_END
