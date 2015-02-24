//
//  InfoViewController.m
//  BaloneyMeter
//
//  Created by Adrian Holzer on 17.01.15.
//  Copyright (c) 2015 Adrian Holzer. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

@synthesize doneButton,infoView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [doneButton setTitle:NSLocalizedString(@"done", nil) forState:UIControlStateNormal];
    [infoView setText:NSLocalizedString(@"info", nil)];
    NSLog(@"Text View Value = %@",infoView.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)done:(id)sender{
         [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)goToWebSite{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.dinerrouge.com"]];
}

@end
