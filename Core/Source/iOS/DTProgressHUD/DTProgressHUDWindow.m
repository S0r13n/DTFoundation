//
//  DTProgressHUDWindow.m
//  DTFoundation
//
//  Created by Stefan Gugarel on 12.05.14.
//  Copyright (c) 2014 Cocoanetics. All rights reserved.
//

#import "DTProgressHUDWindow.h"

#define DegreesToRadians(degrees) (degrees * M_PI / 180)

// local helper function
static CGAffineTransform _transformForInterfaceOrientation(UIInterfaceOrientation orientation)
{
	switch (orientation)
	{
		case UIInterfaceOrientationLandscapeLeft:
		{
			return CGAffineTransformMakeRotation(-DegreesToRadians(90));
		}
		case UIInterfaceOrientationLandscapeRight:
		{
			return CGAffineTransformMakeRotation(DegreesToRadians(90));
		}
		case UIInterfaceOrientationPortraitUpsideDown:
		{
			return CGAffineTransformMakeRotation(DegreesToRadians(180));
		}
		default:
		case UIInterfaceOrientationPortrait:
		{
			return CGAffineTransformMakeRotation(DegreesToRadians(0));
		}
	}
}

@implementation DTProgressHUDWindow

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self)
	{
		[self _setup];
	}
	return self;
}

- (instancetype)init
{
	self = [super init];
	
	if (self)
	{
		[self _setup];
	}
	return self;
}

- (void)_setup
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarDidChangeFrame:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
	
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	[self setTransform:_transformForInterfaceOrientation(orientation)];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)statusBarDidChangeFrame:(NSNotification *)notification
{
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	[self setTransform:_transformForInterfaceOrientation(orientation)];
}

@end
