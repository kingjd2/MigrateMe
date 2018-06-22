//
//  VehicleTableViewCell.h
//  MigrateMe
//
//  Created by Jonathan King on 6/22/18.
//  Copyright © 2018 CarMax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceMilesLabel;
@property (weak, nonatomic) IBOutlet UILabel *featuresLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
