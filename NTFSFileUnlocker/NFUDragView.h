//
//  NFUDragView.h
//  NTFSFileUnlocker
//
//  Created by phbz on 2025/9/17.
//  Copyright © 2025 phbz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

@interface NFUDragView : NSView

@property (assign) id openerDelegate;

#pragma mark NSView Methods

- (void)drawRect:(NSRect)dirtyRect;

#pragma mark NSDraggingDestination Protocol Methods

- (NSDragOperation)draggingEntered:(id < NSDraggingInfo >)sender;
- (NSDragOperation)draggingUpdated:(id < NSDraggingInfo >)sender;
- (void)draggingExited:(id < NSDraggingInfo >)sender;
- (BOOL)prepareForDragOperation:(id < NSDraggingInfo >)sender;
- (BOOL)performDragOperation:(id < NSDraggingInfo >)sender;
- (BOOL)checkIsDictionaryAt:(NSString*) path;

@end
