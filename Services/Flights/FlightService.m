//
//  FlightService.m
//  CodeExample-Objc
//
//  Created by Edward Kim on 2/19/24.
//

#import "FlightService.h"
#import "Flight.h"
@import Firebase;
@import FirebaseFirestore;

@implementation FlightService {
	FIRFirestore *_db;
	FIRCollectionReference *_flightsCollection;
	id<FIRListenerRegistration> _listener;
}

+ (instancetype)shared {
	static FlightService *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});
	return sharedInstance;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		_db = [FIRFirestore firestore];
		_flightsCollection = [_db collectionWithPath:@"Flights"];
	}
	return self;
}

- (void)startListeningWithCompletion:(void (^)(NSArray<Flight *> *))completion {
	_listener = [_flightsCollection addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
		if (error) {
			NSLog(@"Error fetching documents: %@", error);
			return;
		}
		
		NSMutableArray<Flight *> *flights = [NSMutableArray array];
		for (FIRDocumentSnapshot *document in snapshot.documents) {
			Flight *flight = [[Flight alloc] initWithSnapshot:document];
			if (flight) {
				[flights addObject:flight];
			} else {
				NSLog(@"Error decoding flight");
			}
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			completion([flights copy]);
		});
	}];
}


- (void)getFlightsWithCompletion:(void (^)(NSArray<Flight *> *))completion {
	[_flightsCollection getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
		if (error) {
			NSLog(@"Error fetching documents: %@", error);
			completion(@[]);
			return;
		}
		
		NSMutableArray<Flight *> *flights = [NSMutableArray array];
		for (FIRDocumentSnapshot *document in snapshot.documents) {
			Flight *flight = [[Flight alloc] initWithSnapshot:document];
			if (flight) {
				[flights addObject:flight];
			} else {
				NSLog(@"Error decoding flight");
			}
		}
		
		completion([flights copy]);
	}];
}

- (void)stopListening {
	[_listener remove];
	_listener = nil;
}

@end
