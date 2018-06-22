//
//  ViewController.m
//  MigrateMe
//
//  Created by Jonathan King on 6/22/18.
//  Copyright © 2018 CarMax. All rights reserved.
//

#import "ViewController.h"
#import "VehiclesModel.h"
#import "VehicleModel.h"
#import "VehicleTableViewCell.h"
#import "VehiclesService.h"

static NSString *_cellIdentifier = @"VehicleCell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) VehiclesModel *vehicles;
@property (nonatomic, strong) NSNumberFormatter *priceFormatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.priceFormatter = [[NSNumberFormatter alloc] init];
    [self.priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [self.priceFormatter setMaximumFractionDigits:0];
    [self.priceFormatter setCurrencySymbol:@"$"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[VehiclesService shared] getVehicles:^(VehiclesModel *vehicles) {
        self.vehicles = vehicles;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vehicles.vehicles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VehicleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    VehicleModel *vehicle = [self.vehicles.vehicles objectAtIndex:indexPath.row];
    
    NSString *formattedPrice = [self.priceFormatter stringFromNumber:vehicle.price];
    NSString *priceMilesFormat = NSLocalizedString(@"%@ • %@ Miles", comment: @"format to display price and miles on the vehicle's price miles label");
    
    cell.descriptionLabel.text = vehicle.vehicleDescription;
    cell.priceMilesLabel.text = [NSString stringWithFormat:priceMilesFormat, formattedPrice, vehicle.miles];
    cell.featuresLabel.text = vehicle.highlights;
    cell.locationLabel.text = vehicle.storeName;
    
    return cell;
}

@end
