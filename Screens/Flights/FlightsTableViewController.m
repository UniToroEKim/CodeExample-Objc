//
//  FlightsTableViewController.m
//  CodeExample-Objc
//
//  Created by Edward Kim on 2/19/24.
//

#import "FlightsTableViewController.h"
#import "FlightService.h"
#import "FlightsCell.h"
#import "Flight.h"

@interface FlightsTableViewController ()<UISearchResultsUpdating>
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) FlightService *flightService;
@property (nonatomic, strong) NSArray<Flight *> *flights;
@property (nonatomic, strong) NSArray<Flight *> *filteredFlights;
@end

@implementation FlightsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.flightService = FlightService.shared;
	
	// Setup the search controller
	self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
	self.searchController.searchResultsUpdater = self;
	self.navigationItem.searchController = self.searchController;
	self.definesPresentationContext = YES;
	
	self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
	self.navigationController.navigationBar.prefersLargeTitles = YES;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.flightService startListeningWithCompletion:^(NSArray<Flight *> *flights) {
		self.flights = flights;
		[self.tableView reloadData];
	}];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.flightService stopListening];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.searchController.isActive && self.searchController.searchBar.text.length > 0) {
		return self.filteredFlights.count;
	}
	return self.flights.count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	//ASSUMPTION MADE HERE Should be from Service
	return @"United Airlines";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	FlightsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"default" forIndexPath:indexPath];
	
	Flight *flight;
	if (self.searchController.isActive && self.searchController.searchBar.text.length > 0) {
		flight = self.filteredFlights[indexPath.row];
	} else {
		flight = self.flights[indexPath.row];
	}
	
	cell.titleLabel1.text = [NSString stringWithFormat:@"%@", flight.number];
	cell.titleLabel2.text = [NSString stringWithFormat:@"%@→%@", flight.departureAirport, flight.arrivalAirport];
	cell.detailLabel1.text = [NSString stringWithFormat:@"%@", flight.formArrivalTime];
	cell.detailLabel2.text = [NSString stringWithFormat:@"%@", flight.formDepartureTime];
	cell.detailLabel3.text = [NSString stringWithFormat:@"%@", flight.flightID];
	return cell;
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
	NSString *searchText = searchController.searchBar.text;
	if (searchText.length == 0) {
		self.filteredFlights = self.flights;
	} else {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"airline CONTAINS[cd] %@ OR number CONTAINS[cd] %@ OR departureAirport CONTAINS[cd] %@ OR arrivalAirport CONTAINS[cd] %@ OR flightID CONTAINS[cd] %@", searchText, searchText, searchText, searchText, searchText];
		self.filteredFlights = [self.flights filteredArrayUsingPredicate:predicate];
	}
	[self.tableView reloadData];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
