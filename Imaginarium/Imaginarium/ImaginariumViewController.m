//
//  ImaginariumViewController.m
//  Imaginarium
//
//  Created by Snake on 12-12-19.
//  Copyright (c) 2012年 wellsnake. All rights reserved.
//

#import "ImaginariumViewController.h"

@interface ImaginariumViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ImaginariumViewController

- (UIImageView *)imageView{
    if (!_imageView){
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"Giants.jpg"];
    }
    return _imageView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.scrollView.delegate = self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.image.size;//先将scrollview的contentsize设置成图片的大小
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);//CGRectMake用于生成矩形，此处就是将图片的尺寸设置成图片的长和宽组成的矩形
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
@end
