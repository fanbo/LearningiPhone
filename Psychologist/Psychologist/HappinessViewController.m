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
@property (nonatomic,weak) IBOutlet UIToolbar *toolbar;
@end

@implementation HappinessViewController
@synthesize happiness=_happiness;
@synthesize faceView=_faceView;
@synthesize splitViewBarButtonItem=_splitViewBarButtonItem;
@synthesize toolbar=_toolbar;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self handleSplitViewBarButtonItem:self.splitViewBarButtonItem];
}

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem{
    if (splitViewBarButtonItem!=_splitViewBarButtonItem){
        [self handleSplitViewBarButtonItem:splitViewBarButtonItem];
    }
}
- (void)handleSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem{
    NSMutableArray *toolbarItems=[self.toolbar.items mutableCopy];//获得当前toolbar的按钮数组，将不可变数组放入可变数组内，便于以后编辑数组
    if (_splitViewBarButtonItem) [toolbarItems removeObject:_splitViewBarButtonItem];//如果原来的按钮不为空那么将原来的按钮删除
    if (splitViewBarButtonItem) [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];//如果传入的按钮不为空，那么将按钮加入到可变数组内
    self.toolbar.items=toolbarItems;//将编辑好的可变数组给当前toolbar的按钮数组
    _splitViewBarButtonItem=splitViewBarButtonItem;
}

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
