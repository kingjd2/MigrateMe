//
//  VehiclesService.m
//  MigrateMe
//
//  Created by Jonathan King on 6/22/18.
//  Copyright © 2018 CarMax. All rights reserved.
//

#import "VehiclesService.h"
#import "VehicleModel.h"

static VehiclesService *sharedInstance;

@implementation VehiclesService
+(VehiclesService*) shared
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)getVehicles:(void(^)(VehiclesModel *vehicles))onCompletion {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"vehicles" withExtension:@"plist"];
        NSDictionary *vehiclesDict = [NSDictionary dictionaryWithContentsOfURL:url];
        
        VehiclesModel *model = [[VehiclesModel alloc] init];
        model.disclaimers = (NSArray*)[vehiclesDict objectForKey:@"DisclaimerText"];
        
        NSMutableArray *vehicles = [[NSMutableArray alloc] init];
        
        NSArray *resultsArray = (NSArray*)[vehiclesDict objectForKey:@"Results"] ;
        
        for (NSDictionary *result in resultsArray) {
            VehicleModel *vehicle = [[VehicleModel alloc] init];
            vehicle.stockNumber = [((NSNumber*)[result objectForKey:@"StockNumber"]) stringValue];
            vehicle.vehicleDescription = (NSString*)[result objectForKey:@"Description"];
            vehicle.price = (NSNumber*)[result objectForKey:@"Price"];
            vehicle.miles = (NSString*)[result objectForKey:@"Miles"];
            vehicle.storeName = (NSString*)[result objectForKey:@"StoreName"];
            vehicle.highlights = (NSString*)[result objectForKey:@"Highlights"];
            [vehicles addObject:vehicle];
        }
        
        model.vehicles = vehicles;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            onCompletion(model);
        });
    });
}


@end
