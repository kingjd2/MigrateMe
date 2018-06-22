//
//  VehiclesService.h
//  MigrateMe
//
//  Created by Jonathan King on 6/22/18.
//  Copyright © 2018 CarMax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehiclesModel.h"

@interface VehiclesService : NSObject

+(VehiclesService *)shared;

-(void)getVehicles:(void(^)(VehiclesModel *vehicles))onCompletion;

@end
