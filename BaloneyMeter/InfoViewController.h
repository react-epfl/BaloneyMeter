//
//  InfoViewController.h
//  BaloneyMeter
//
//  Created by Adrian Holzer on 17.01.15.
//  Copyright (c) 2015 Adrian Holzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

-(IBAction)done:(id)sender;
-(IBAction)goToWebSite;


@property(strong, nonatomic) IBOutlet UIButton * doneButton;
@property(strong, nonatomic) IBOutlet UITextView * infoView;


@end
