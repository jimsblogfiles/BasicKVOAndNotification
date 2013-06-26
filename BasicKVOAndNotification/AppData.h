//
//  AppData.h
//  BasicCoreData
//
//  Created by James Border on 6/24/13.
//  Copyright (c) 2013 James Border. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject {}

+(AppData*)sharedData;

@property (nonatomic, retain) NSString *sanityCheck;

@property (nonatomic, retain) NSString *targetData;
@property (nonatomic, retain) NSString *targetData1;

@end
