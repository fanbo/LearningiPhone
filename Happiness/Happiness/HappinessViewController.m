//
//  HappinessViewController.m
//  Happiness
//
//  Created by Snake on 12-10-10.
//  Copyright (c) 2012年 snake well. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"
@interface HappinessViewController ()<FaceViewDataSource>
@property (nonatomic,weak) IBOutlet FaceView *faceView;
@end

@implementation HappinessViewController
@synthesize happiness=_happiness;
@synthesize faceView=_faceView;

-(float)smileForFaceView:(FaceView *)sender{
    return (self.happiness - 50) / 50.0;
}

-(void)setHappiness:(int)happiness{
    _happiness=happiness;
    [self.faceView setNeedsDisplay]; //每次设置幸福值的时候view都会重新绘制
}
-(void)setFaceView:(FaceView *)faceView{
    _faceView=faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];
    self.faceView.dataSource=self;
}
-(void)handleHappinessGesture:(UIPanGestureRecognizer *)gesture{
    if((gesture.state==UIGestureRecognizerStateChanged)||(gesture.state==UIGestureRecognizerStateEnded)){
        CGPoint translation=[gesture translationInView:self.faceView];
        self.happiness -= translation.y / 2;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

@end
