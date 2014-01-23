//
//  UIViewController+UINavigationBar.m
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-9-16.
//  Copyright (c) 2013年 Like Say Developer ( https://github.com/titman/LCFramework / USE IN PROJECT http://www.likesay.com ).
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "UIViewController+UINavigationBar.h"

#pragma mark -

#undef	BUTTON_MIN_WIDTH
#define	BUTTON_MIN_WIDTH	(24.0f)

#undef	BUTTON_MIN_HEIGHT
#define	BUTTON_MIN_HEIGHT	(24.0f)

#pragma mark -

@interface UIViewController(UINavigationBarPrivate)
- (void)didLeftBarButtonTouched;
- (void)didRightBarButtonTouched;
@end

#pragma mark -

@implementation UIViewController(UINavigationBar)

+(id) viewController
{
    return [[[[self class] alloc] init] autorelease];
}

- (void)showNavigationBarAnimated:(BOOL)animated
{    
	[self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)hideNavigationBarAnimated:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didLeftBarButtonTouched
{
    [self navigationBarButtonClick:NavigationBarButtonTypeLeft];
}

- (void)didRightBarButtonTouched
{
    [self navigationBarButtonClick:NavigationBarButtonTypeRight];
}

- (void)showBarButton:(NavigationBarButtonType)position title:(NSString *)name textColor:(UIColor *)textColor
{
    UIFont  * font = [UIFont systemFontOfSize:13];
    UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)] autorelease];
    CGSize size = [name sizeWithFont:font constrainedToSize:label.frame.size lineBreakMode:NSLineBreakByWordWrapping];
    label.frame = LC_RECT_CREATE(0, 0, size.width, size.height);
    label.text = name;
    label.textColor = textColor;
    label.backgroundColor = [UIColor clearColor];
    
	if ( NavigationBarButtonTypeLeft == position )
	{
        [self showBarButton:NavigationBarButtonTypeLeft custom:label];
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
        [self showBarButton:NavigationBarButtonTypeRight custom:label];
	}
}

- (void)showBarButton:(NavigationBarButtonType)position image:(UIImage *)image selectImage:(UIImage *)selectImage
{
	CGRect buttonFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    
	if ( buttonFrame.size.width <= BUTTON_MIN_WIDTH )
	{
		buttonFrame.size.width = BUTTON_MIN_WIDTH;
	}
    
	if ( buttonFrame.size.height <= BUTTON_MIN_HEIGHT )
	{
		buttonFrame.size.height = BUTTON_MIN_HEIGHT;
	}
    
	LC_UIButton * button = [[[LC_UIButton alloc] initWithFrame:buttonFrame] autorelease];
	button.contentMode = UIViewContentModeScaleAspectFit;
	button.backgroundColor = [UIColor clearColor];
	[button setImage:image forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateHighlighted];
	button.titleFont = [UIFont boldSystemFontOfSize:13.0f];
	button.titleColor = LC_UINAVIGATION_BAR_DEFAULT_BUTTON_TITLE_COLOR;
    
	if ( NavigationBarButtonTypeLeft == position )
	{
		[button addTarget:self action:@selector(didLeftBarButtonTouched) forControlEvents:UIControlEventTouchUpInside];
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:(UIView *)button] autorelease];
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
		[button addTarget:self action:@selector(didRightBarButtonTouched) forControlEvents:UIControlEventTouchUpInside];
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:(UIView *)button] autorelease];
	}
}

- (void)showBarButton:(NavigationBarButtonType)position title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage
{
	CGRect buttonFrame = CGRectMake(0, 0, image.size.width, image.size.height);
	
	if ( buttonFrame.size.width <= BUTTON_MIN_WIDTH )
	{
		buttonFrame.size.width = BUTTON_MIN_WIDTH;
	}
	
	if ( buttonFrame.size.height <= BUTTON_MIN_HEIGHT )
	{
		buttonFrame.size.height = BUTTON_MIN_HEIGHT;
	}
    
	LC_UIButton * button = [[[LC_UIButton alloc] initWithFrame:buttonFrame] autorelease];
	button.contentMode = UIViewContentModeScaleAspectFit;
	button.backgroundColor = [UIColor clearColor];
	[button setImage:image forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateHighlighted];
	button.title = title;
	button.titleFont = [UIFont boldSystemFontOfSize:13.0f];
	button.titleColor = LC_UINAVIGATION_BAR_DEFAULT_BUTTON_TITLE_COLOR;
	
	if ( NavigationBarButtonTypeLeft == position )
	{
		[button addTarget:self action:@selector(didLeftBarButtonTouched) forControlEvents:UIControlEventTouchUpInside];
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
		[button addTarget:self action:@selector(didRightBarButtonTouched) forControlEvents:UIControlEventTouchUpInside];
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
	}
}

- (void)showBarButton:(NavigationBarButtonType)position system:(UIBarButtonSystemItem)index
{
	if ( NavigationBarButtonTypeLeft == position )
	{
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:index
																							   target:self
																							   action:@selector(didLeftBarButtonTouched)] autorelease];
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:index
																								target:self
																								action:@selector(didRightBarButtonTouched)] autorelease];
	}
}

- (void)showBarButton:(NavigationBarButtonType)position custom:(UIView *)view
{
	if ( NavigationBarButtonTypeLeft == position )
	{
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:view] autorelease];
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:view] autorelease];
	}
}

- (void)hideBarButton:(NavigationBarButtonType)position
{
	if ( NavigationBarButtonTypeLeft == position )
	{
		self.navigationItem.leftBarButtonItem = nil;
	}
	else if ( NavigationBarButtonTypeRight == position )
	{
		self.navigationItem.rightBarButtonItem = nil;
	}
}

-(void) navigationBarButtonClick:(NavigationBarButtonType)type
{
    
}


@end

