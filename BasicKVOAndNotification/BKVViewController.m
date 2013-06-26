//
//  BKVViewController.m
//  BasicKVOAndNotification
//
//  Created by James Border on 6/25/13.
//  Copyright (c) 2013 James Border. All rights reserved.
//

#import "BKVViewController.h"
#import "BKVEditViewController.h"

#import "AppData.h"

@interface BKVViewController () {

    AppData *appData;
    
    UIPopoverController *popoverController;
	BKVEditViewController *editViewController;

}

@property (weak, nonatomic) IBOutlet UILabel *txtTargetData;
@property (weak, nonatomic) IBOutlet UILabel *txtTargetData1;

@end

@implementation BKVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    appData = [AppData sharedData];
    
    NSLog(@"BKVViewController->appData.sanityCheck:%@",appData.sanityCheck);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearFields:) name:@"ClearFieldsNSNotification" object: nil];
    
	[appData addObserver:self
              forKeyPath:@"targetData"
                 options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                 context:NULL];
    
	[appData addObserver:self
              forKeyPath:@"targetData1"
                 options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                 context:NULL];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath
					 ofObject:(id)object
					   change:(NSDictionary *)change
					  context:(void *)context {
	
	NSLog(@"keyPath:%@",keyPath);
	NSLog(@"object:%@",object);
	NSLog(@"change:%@",change);
    
	if ( [keyPath isEqualToString:@"targetData"] ) {
        [_txtTargetData setText:[change objectForKey:@"new"] ];
	}

	if ( [keyPath isEqualToString:@"targetData1"] ) {
        [_txtTargetData1 setText:[change objectForKey:@"new"] ];
	}
	
}

-(void)clearFields:(NSNotification *)notif {
	
	NSLog(@"notif.object:%@",notif.object);
    
    [_txtTargetData setText:@""];
    [_txtTargetData1 setText:@""];
	
}

#pragma mark -
#pragma mark EDIT VIEW POPOVER/MODAL HERE

- (IBAction)actionPopover:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    editViewController = (BKVEditViewController *)[storyboard instantiateViewControllerWithIdentifier:@"EditView"];
    editViewController.parent = self;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        [self presentViewController:editViewController animated:YES completion:nil];
        
    } else {
        
        UIButton *button = sender;
        
        popoverController = [[UIPopoverController alloc] initWithContentViewController:editViewController];
        [popoverController setDelegate:(id <UIPopoverControllerDelegate>)self];
        [popoverController presentPopoverFromRect:button.frame
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
        
    }
    
}

- (void)dismissView:(id)sender {

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popoverController dismissPopoverAnimated:YES];
    }
    
}

#pragma mark -
#pragma mark

-(void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self  name:@"ClearFieldsNSNotification" object:nil];

    [appData removeObserver:self forKeyPath:@"targetData"];
    [appData removeObserver:self forKeyPath:@"targetData1"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
