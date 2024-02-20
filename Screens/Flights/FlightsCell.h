//
//  FlightsCell.h
//  CodeExample-Objc
//
//  Created by Edward Kim on 2/19/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlightsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel1;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel2;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel3;

@end

NS_ASSUME_NONNULL_END
