//
//  FlightService.h
//  CodeExample-Objc
//
//  Created by Edward Kim on 2/19/24.
//

#import <Foundation/Foundation.h>

@class Flight;

NS_ASSUME_NONNULL_BEGIN

@interface FlightService : NSObject

+ (instancetype)shared;
- (void)startListeningWithCompletion:(void (^)(NSArray<Flight *> *))completion;
- (void)getFlightsWithCompletion:(void (^)(NSArray<Flight *> *))completion;
- (void)stopListening;

@end
NS_ASSUME_NONNULL_END
