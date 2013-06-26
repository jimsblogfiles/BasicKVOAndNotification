//
//  AppData.m
//  BasicCoreData
//
//  Created by James Border on 6/24/13.
//  Copyright (c) 2013 James Border. All rights reserved.
//

#import "AppData.h"

@implementation AppData

static AppData* _sharedData = nil;

-(id)init {
	
	self = [super init];
	
	if (self != nil) {

        _sanityCheck = @"Connected";
        
    }

    return self;

}

#pragma mark -
#pragma mark Class Methods

+(AppData*)sharedData {
    
    @synchronized(self) {
		
        if (_sharedData == nil) {
			_sharedData = [[self alloc] init];
		}

    }
	
    return _sharedData;
    
}

+(id)alloc {
	
	@synchronized([AppData class]) {
		
		NSAssert(_sharedData == nil, @"Attempted to allocate a second instance of a singleton.");
		
        _sharedData = [super alloc];
		
		return _sharedData;
        
	}
	
	return nil;
	
}


@end
