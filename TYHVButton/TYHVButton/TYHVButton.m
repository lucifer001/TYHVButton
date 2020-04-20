//
//  MCHVButton.m
//  CustomBtnDemo
//
//  Created by Tianyu on 15/6/12.
//  Copyright (c) 2015年 com.hoolai. All rights reserved.
//

#import "TYHVButton.h"

@interface TYHVButton ()

@end

@implementation TYHVButton

//code
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.space = 8;
        [self setContentEdgeInsets:UIEdgeInsetsZero];
        [self makeEdgeHighlighted:self.highlighted];
    }
    return self;
}

//XIB
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.space = 5;
        [self setContentEdgeInsets:UIEdgeInsetsZero];
        [self makeEdgeHighlighted:self.highlighted];
    }
    return self;
}

- (void)setSpace:(CGFloat)space
{
    _space = space;
    [self makeEdgeHighlighted:self.highlighted];
}

- (void)setImage_size:(CGSize)image_size
{
    UIImage *tempImage = [self imageForState:UIControlStateNormal];
    if (tempImage && tempImage.size.width!=image_size.width && tempImage.size.width!=image_size.height) {
        [self setImage:[self imageScaledToSize:image_size image:tempImage] forState:UIControlStateNormal];
    }
    
    tempImage = [self imageForState:UIControlStateHighlighted];
    if (tempImage && tempImage.size.width!=image_size.width && tempImage.size.width!=image_size.height) {
        [self setImage:[self imageScaledToSize:image_size image:tempImage] forState:UIControlStateHighlighted];
    }
    
    tempImage = [self imageForState:UIControlStateSelected];
    if (tempImage && tempImage.size.width!=image_size.width && tempImage.size.width!=image_size.height) {
        [self setImage:[self imageScaledToSize:image_size image:tempImage] forState:UIControlStateSelected];
    }
}

- (UIImage *)imageScaledToSize:(CGSize)newSize image:(UIImage *)image
{
    newSize.width = (int)newSize.width;
    newSize.height = (int)newSize.height;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    [self makeEdgeHighlighted:self.highlighted];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self makeEdgeHighlighted:self.highlighted];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self makeEdgeHighlighted:self.highlighted];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self makeEdgeHighlighted:self.highlighted];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [self makeEdgeHighlighted:highlighted];
}

- (void)makeEdgeHighlighted:(BOOL)highlighted
{
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    
    NSString *_text;
    UIImage *_image;
    
    if (highlighted) {
        _text = [self titleForState:UIControlStateHighlighted];
        _image = [self imageForState:UIControlStateHighlighted];
    }
    else if (self.selected){
        _text = [self titleForState:UIControlStateSelected];
        _image = [self imageForState:UIControlStateSelected];
    }
    else{
        _text = [self titleForState:UIControlStateNormal];
        _image = [self imageForState:UIControlStateNormal];
    }
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;

    CGSize size = [self sizeWithFont:self.titleLabel.font
                   constrainedToSize:CGSizeMake(CGFLOAT_MAX, self.titleLabel.bounds.size.height)
                                text:_text];

    CGFloat btnWidth = self.bounds.size.width;

    CGFloat btnHeight = self.bounds.size.height;
    
    CGFloat imgHeight = _image.size.height;

    CGFloat imgCenterX = self.imageView.center.x;

    CGFloat textHeight = self.titleLabel.bounds.size.height;
    
    CGFloat textCenterX = size.width/2 + self.titleLabel.frame.origin.x;
    
    CGFloat top = (btnHeight - (imgHeight + self.space + textHeight)) / 2 ;

    [self setImageEdgeInsets:UIEdgeInsetsMake(top, (btnWidth / 2 - imgCenterX), 0, 0)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imgHeight + self.space + top, (btnWidth / 2 - textCenterX), 0, 0)];
}

- (CGSize)sizeWithFont:(UIFont*)tFont constrainedToSize:(CGSize)consize text:(NSString *)text
{
    if (!(text.length > 0)) {
        text = @"";
    }
    CGSize contentTextSize = CGSizeZero;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: tFont}];
    contentTextSize = [attrStr boundingRectWithSize:consize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                            context:nil].size;
    contentTextSize = CGSizeMake(ceilf(contentTextSize.width), ceilf(contentTextSize.height));
    
    return contentTextSize;
}




@end
