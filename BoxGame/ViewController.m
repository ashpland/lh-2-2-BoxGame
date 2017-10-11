//
//  ViewController.m
//  BoxGame
//
//  Created by Andrew on 2017-10-10.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSUInteger, BackgroundBoxes) {
    Center,
    Center_Left,
    Top_Left,
    Top_Center,
    Top_Right,
    Center_Right,
    Bottom_Right,
    Bottom_Center,
    Bottom_Left,
};




@interface ViewController ()

@property (nonatomic, strong) NSArray<UIView *> *backgroundBoxes;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *backgroundBoxConstraints;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackgroundStructure];
    






}

- (void)setupBackgroundStructure {
    
    NSMutableArray<UIView *> *buildingArray = [NSMutableArray new];
    self.backgroundBoxConstraints = [NSMutableArray new];
    
    // initialize the views
    
    for (int i = 0; i < 9; i++) {
        
        UIView *newView = [[UIView alloc] initWithFrame:CGRectMake((25 * i), 20, 20, 20)];
        //UIView *newView = [[UIView alloc] initWithFrame:CGRectZero];
        newView.translatesAutoresizingMaskIntoConstraints = NO;
        newView.backgroundColor = [UIColor blueColor];
        newView.alpha = 0;
        [self.view addSubview:newView];
        [buildingArray addObject:newView];
    }
    
    self.backgroundBoxes = buildingArray;


    // setup center box
    
    [self.backgroundBoxConstraints addObject:[NSLayoutConstraint constraintWithItem:buildingArray[Center] attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.backgroundBoxConstraints addObject:[NSLayoutConstraint constraintWithItem:buildingArray[Center] attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.backgroundBoxConstraints addObject:[NSLayoutConstraint constraintWithItem:buildingArray[Center] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:(1/3.0) constant:0]];
    [self.backgroundBoxConstraints addObject:[NSLayoutConstraint constraintWithItem:buildingArray[Center] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:(1/3.0) constant:0]];

    buildingArray[Center].alpha = 1;
    
    
    // Size for all other boxes
    for (int i = 1; i < 9; i++) {
        [self.backgroundBoxConstraints addObject:[NSLayoutConstraint constraintWithItem:buildingArray[i] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:buildingArray[Center] attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
        [self.backgroundBoxConstraints addObject:[NSLayoutConstraint constraintWithItem:buildingArray[i] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:buildingArray[Center] attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    }
    
    // add alternating colours
    for (UIView *currentView in @[buildingArray[Top_Left], buildingArray[Top_Right], buildingArray[Center], buildingArray[Bottom_Left], buildingArray[Bottom_Right]]) {
        currentView.backgroundColor = [UIColor orangeColor];
    }
    
    // align left column
    [self alignViewsIn:@[buildingArray[Top_Left], buildingArray[Center_Left], buildingArray[Bottom_Left]] fromTheir:NSLayoutAttributeRight toThe:NSLayoutAttributeLeft ofView:buildingArray[Center]];
    
    // align center column
    [self alignViewsIn:@[buildingArray[Top_Center], buildingArray[Bottom_Center]] fromTheir:NSLayoutAttributeCenterX toThe:NSLayoutAttributeCenterX ofView:buildingArray[Center]];

    // align right column
    [self alignViewsIn:@[buildingArray[Top_Right], buildingArray[Center_Right], buildingArray[Bottom_Right]] fromTheir:NSLayoutAttributeLeft toThe:NSLayoutAttributeRight ofView:buildingArray[Center]];
    
    // align top row
    [self alignViewsIn:@[buildingArray[Top_Left], buildingArray[Top_Center], buildingArray[Top_Right]] fromTheir:NSLayoutAttributeBottom toThe:NSLayoutAttributeTop ofView:buildingArray[Center]];
 
    // align center row
    [self alignViewsIn:@[buildingArray[Center_Left], buildingArray[Center_Right]] fromTheir:NSLayoutAttributeCenterY toThe:NSLayoutAttributeCenterY ofView:buildingArray[Center]];
    
    // align bottom row
    [self alignViewsIn:@[buildingArray[Bottom_Left], buildingArray[Bottom_Center], buildingArray[Bottom_Right]] fromTheir:NSLayoutAttributeTop toThe:NSLayoutAttributeBottom ofView:buildingArray[Center]];
    
    
    for (int i = 1; i < 9; i++) {
        buildingArray[i].alpha = 1;
    }


    
    
    for(NSLayoutConstraint *curConstraint in self.backgroundBoxConstraints){
        curConstraint.active = YES;
    }
    
}

- (void)alignViewsIn:(NSArray<UIView *> *)viewsArray fromTheir:(NSLayoutAttribute)alignSide toThe:(NSLayoutAttribute)anchorSide ofView:(UIView *)toMatchTo
{
    for(UIView *currentView in viewsArray){
        [self.backgroundBoxConstraints addObject:[NSLayoutConstraint constraintWithItem:currentView attribute:alignSide relatedBy:NSLayoutRelationEqual toItem:toMatchTo attribute:anchorSide multiplier:1.0 constant:0]];
    }
    

}


@end
