//
//  VehicleModel.h
//  MigrateMe
//
//  Created by Jonathan King on 6/22/18.
//  Copyright © 2018 CarMax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleModel : NSObject

@property (nonatomic, strong) NSString *stockNumber;
@property (nonatomic, strong) NSString *vehicleDescription;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *highlights;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *miles;

@end
