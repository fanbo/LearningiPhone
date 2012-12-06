//
//  FaceView.h
//  Happiness
//
//  Created by Snake on 12-10-10.
//  Copyright (c) 2012年 snake well. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FaceView;
@protocol FaceViewDataSource
-(float) smileForFaceView:(FaceView *)sender;
@end

@interface FaceView : UIView
@property (nonatomic) CGFloat scale;
-(void)pinch:(UIPinchGestureRecognizer *)gesture;
@property (nonatomic,weak) IBOutlet id<FaceViewDataSource> dataSource;
@end
