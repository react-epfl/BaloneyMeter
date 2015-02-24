//
//  ProfileTableViewController.m
//  Chachachat
//
//  Created by Adrian Holzer on 11.07.13.
//
//

#import "BMTableViewController.h"
#import "Characteristic.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

#define MAX_SLIDER 100

@interface BMTableViewController ()

@end

@implementation BMTableViewController

@synthesize scoreLabel,characteristics,score, questionLabel, becauseLabel, commentTextView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [super viewDidLoad];
    
    
    becauseLabel.text=NSLocalizedString(@"because0", nil);
    questionLabel.text=NSLocalizedString(@"question", nil);
    commentTextView.text=@"";
    
    characteristics=[[NSMutableArray alloc] init];
    Characteristic  *char5= [[Characteristic alloc] init];
    char5.name=NSLocalizedString(@"extraordinary?", nil);
    char5.currentIndex=-1;
    char5.values=[NSArray arrayWithObjects:
                  NSLocalizedString(@"extraordinary1",nil),
                  NSLocalizedString(@"extraordinary2",nil),
                  NSLocalizedString(@"extraordinary3",nil),
                  NSLocalizedString(@"extraordinary4",nil),
                  NSLocalizedString(@"extraordinary5",nil), nil];
    [characteristics addObject:char5];
    Characteristic  *char1= [[Characteristic alloc] init];
    char1.name=NSLocalizedString(@"source?",nil);
    char1.currentIndex=-1;
    char1.values=[NSArray arrayWithObjects:
                  NSLocalizedString(@"source1",nil),
                  NSLocalizedString(@"source2",nil),
                  NSLocalizedString(@"source3",nil),
                  NSLocalizedString(@"source4",nil),
                  NSLocalizedString(@"source5",nil), nil];
    [characteristics addObject:char1];
    Characteristic  *char2= [[Characteristic alloc] init];
    char2.name=NSLocalizedString(@"testable?",nil);
    char2.currentIndex=-1;
    char2.values=[NSArray arrayWithObjects:
                  NSLocalizedString(@"testable1",nil),
                  NSLocalizedString(@"testable2",nil),
                  NSLocalizedString(@"testable3",nil),
                  NSLocalizedString(@"testable4",nil),
                  NSLocalizedString(@"testable5",nil), nil];
    [characteristics addObject:char2];
    Characteristic  *char3= [[Characteristic alloc] init];
    char3.name=NSLocalizedString(@"positive?",nil);
    char3.currentIndex=-1;
    char3.values=[NSArray arrayWithObjects:
                  NSLocalizedString(@"positive1",nil),
                  NSLocalizedString(@"positive2",nil),
                  NSLocalizedString(@"positive3",nil),
                  NSLocalizedString(@"positive4",nil),
                  NSLocalizedString(@"positive5",nil), nil];
    
    [characteristics addObject:char3];
    Characteristic  *char4= [[Characteristic alloc] init];
    char4.name=NSLocalizedString(@"negative?",nil);
    char4.currentIndex=-1;
    char4.values=[NSArray arrayWithObjects:
                  NSLocalizedString(@"negative1",nil),
                  NSLocalizedString(@"negative2",nil),
                  NSLocalizedString(@"negative3",nil),
                  NSLocalizedString(@"negative4",nil),
                  NSLocalizedString(@"negative5",nil), nil];
    [characteristics addObject:char4];
    score=-1;
    [self updateScore];
    NSLog(@"score %d", self.score);
    
}

-(NSString*)scoreString{
    NSString* adjective;
    if (self.score ==-1 ) {
        adjective= NSLocalizedString(@"score0", nil);
    }else if (self.score <MAX_SLIDER) {
        adjective= NSLocalizedString(@"score1", nil);
    }else if(self.score <MAX_SLIDER*2 ) {
        adjective= NSLocalizedString(@"score2", nil);
    }else if(self.score <MAX_SLIDER*3 ) {
        adjective= NSLocalizedString(@"score3", nil);
    }else if (self.score <MAX_SLIDER*4.5) {
        adjective= NSLocalizedString(@"score4", nil);
    }else{
        adjective= NSLocalizedString(@"score5", nil);
    }
    return adjective;
}

- (void)viewDidAppear:(BOOL)animated
{
    [[[GAI sharedInstance] defaultTracker] set:kGAIScreenName value:@"Inequality Screen"];
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createAppView] build]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return characteristics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CharacteristicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UISlider *slider = (UISlider *)[cell viewWithTag:1];
    UILabel *currentValueLabel = (UILabel *)[cell viewWithTag:4];
    Characteristic* characteristic =[characteristics objectAtIndex:indexPath.row];
    slider.maximumValue=MAX_SLIDER-1;
    if (characteristic.currentIndex == -1) {
        currentValueLabel.text=[characteristic name];
        slider.value=0;
    }else{
        int sliderIndex = characteristic.currentIndex/(MAX_SLIDER/[characteristic.values count]);
        currentValueLabel.text = [characteristic.values objectAtIndex:sliderIndex];
        slider.value=characteristic.currentIndex;
    }
    cell.backgroundColor=tableView.backgroundColor;
    //slider.backgroundColor=[UIColor redColor];
    return cell;
}

-(IBAction)resetCharacteristics:(id)sender{
    for ( Characteristic* characteristic in characteristics){
        characteristic.currentIndex = -1;
    }
    score=-1;
    [self updateScore];
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"  action:@"button_press" label:@"reset" value:nil] build]];
    
}

-(IBAction)sliderValueChanged:(UISlider *)sender{
    score=0;
    UITableViewCell *cell = (UITableViewCell*) sender.superview;
    UILabel *currentValueLabel = (UILabel *)[cell viewWithTag:4];
    // get the correct characteristic
    CGPoint sliderPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:sliderPosition];
    Characteristic* characteristic =[characteristics objectAtIndex:[indexPath row]];
    characteristic.currentIndex=sender.value;
    int valueIndex = characteristic.currentIndex/(MAX_SLIDER/[characteristic.values count]);
    characteristic.value=[characteristic.values objectAtIndex:valueIndex];
    currentValueLabel.text=characteristic.value;
    [self updateScore];
}


-(void)updateScore{
    score=0;
    BOOL notAllSlidersAreSet=NO;
    //calculating the score
    NSString* commentNameString=@"comment";
    for(Characteristic *characteristic in characteristics){
        if (characteristic.currentIndex != -1) {
            score += characteristic.currentIndex;
            if (characteristic.currentIndex<=MAX_SLIDER/2) {
                commentNameString = [NSString stringWithFormat:@"%@0",commentNameString];
            }else{
                commentNameString = [NSString stringWithFormat:@"%@1",commentNameString];
            }
        }else{
            notAllSlidersAreSet=YES;
        }
    }
    NSLog(@"score %d", self.score);
    //change the color
    double maxColor = 219.0;
    double redScoreLimit = 300.0;
    double greenScoreLimit = 250.0;
    GLfloat red = 219.0;
    GLfloat green = 0.0;
    GLfloat blue= 0.0;
    float maxscore = [characteristics count]*MAX_SLIDER;
    if (score<redScoreLimit) {
        red=maxColor;
    }else{
        double x = maxColor/(maxscore-redScoreLimit);
        red = maxColor - (score-redScoreLimit)*x;
    }
    if (score>greenScoreLimit) {
        green=maxColor;
    }else{
        double x = maxColor/greenScoreLimit;
        green = score*x;
    }
    NSLog(@"red %f, green %f, blue %f", red, green, blue);
    self.tableView.backgroundColor=[UIColor colorWithRed:red/255.0  green:green/255.0 blue:blue/255.0 alpha:1.0];
    
    if (notAllSlidersAreSet) {
        //reseting the score to -1 if not all sliders are set
        score=-1;
        becauseLabel.text=@"";
        commentTextView.text=NSLocalizedString(@"comment", nil);
        scoreLabel.text = [self scoreString];
    }else{
        becauseLabel.text=@"";
        scoreLabel.text = [self scoreString];
        commentTextView.text=NSLocalizedString(commentNameString, nil);
    }
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
