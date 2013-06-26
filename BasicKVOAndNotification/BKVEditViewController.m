//
//  BKVEditViewController
//  BasicKVOAndNotification
//
//  Created by James Border on 6/25/13.
//  Copyright (c) 2013 James Border. All rights reserved.
//

#import "BKVEditViewController.h"
#import "BKVViewController.h"

#import "AppData.h"

@interface BKVEditViewController () {

    AppData *appData;

}

@property (weak, nonatomic) IBOutlet UITextField *txtUserInput;
@property (weak, nonatomic) IBOutlet UITextField *txtUserInput1;

- (IBAction)actionNewInput:(id)sender;
- (IBAction)actionClear:(id)sender;

@end

@implementation BKVEditViewController

- (IBAction)actionNewInput:(id)sender {

    if (_txtUserInput.text) {
        [appData setTargetData:_txtUserInput.text];
    }

    if (_txtUserInput1.text) {
        [appData setTargetData1:_txtUserInput1.text];
    }

}

- (IBAction)actionClear:(id)sender {

    [appData setTargetData:@""];
    [appData setTargetData1:@""];

    [_txtUserInput setText:@""];
    [_txtUserInput1 setText:@""];

    NSString *demoString = @"Completely unnecessary string here, it's only here to demo sending/receiving an object through the notification";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClearFieldsNSNotification" object:demoString];

    if ([_parent respondsToSelector:@selector(dismissView:)]) {
		[_parent dismissView:self];
	}

}

- (IBAction)actionDone:(id)sender {

    if (_txtUserInput.text) {
        [appData setTargetData:_txtUserInput.text];
    }
    
    if (_txtUserInput1.text) {
        [appData setTargetData1:_txtUserInput1.text];
    }
    
    if ([_parent respondsToSelector:@selector(dismissView:)]) {
		[_parent dismissView:self];
	}

}


- (void)viewDidLoad
{

    [super viewDidLoad];

	// Do any additional setup after loading the view.
    
    appData = [AppData sharedData];

    NSLog(@"BKVEditViewController->appData.sanityCheck:%@",appData.sanityCheck);

}

-(void)viewWillAppear:(BOOL)animated {

    [_txtUserInput setText:appData.targetData];
    [_txtUserInput1 setText:appData.targetData1];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
