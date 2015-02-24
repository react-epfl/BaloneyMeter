//
//  ProfileTableViewController.h
//  Chachachat
//
//  Created by Adrian Holzer on 11.07.13.
//
//

#import <UIKit/UIKit.h>

@interface BMTableViewController : UITableViewController
@property(strong, nonatomic) IBOutlet UILabel * scoreLabel;
@property(strong, nonatomic) IBOutlet UILabel * questionLabel;
@property(strong, nonatomic) IBOutlet UILabel * becauseLabel;
@property(strong, nonatomic) IBOutlet UITextView * commentTextView;
@property(strong, nonatomic)  NSMutableArray * characteristics;
@property(nonatomic)  int score;

-(IBAction)sliderValueChanged:(UISlider *)sender;

@end
