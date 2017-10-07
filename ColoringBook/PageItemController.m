//
//  PageItemController.m
//  ColoringBook
//
//  Created by MacBook Pro on 12/17/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

#import "PageItemController.h"

@interface PageItemController ()

@end

@implementation PageItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _contentImageView.image = [UIImage imageNamed:_imageName];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Content

- (void)setImageName:(NSString *)name {
    
    _imageName = name;
    _contentImageView.image = [UIImage imageNamed:_imageName];
}

@end
