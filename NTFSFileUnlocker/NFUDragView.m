//
//  NFUDragView.m
//  NTFSFileUnlocker
//
//  Created by phbz on 2025/9/17.
//  Copyright © 2025 phbz. All rights reserved.
//

#import "NFUDragView.h"
#import "AppDelegate.h"

@interface NFUDragView ()
@property BOOL isHighlight;
@end

@implementation NFUDragView

@synthesize openerDelegate;
@synthesize isHighlight;


- (void)drawRect:(NSRect)dirtyRect {
    // Hard codes for drawing window.
    NSRect rect = NSInsetRect([self frame], 5, 5);
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetLineWidth(context, 8);
    CGFloat lengths[] = {55., 25.};
    CGContextSetLineDash(context, 0., lengths, 2);
    CGFloat opaqueGray[] = {0.5, 0.5, 0.5, 1.0}; // red, green, blue, alpha
    CGContextSetStrokeColor(context, opaqueGray);
    CGContextStrokeRect(context, NSRectToCGRect(rect));
    
    // Draw localized strings for the window and set attributes.
    NSString* text = isHighlight?
    NSLocalizedStringFromTable(@"NFUReleaseString", @"MainMenu", @"Release and it will be opened"):
    NSLocalizedStringFromTable(@"NFUDragString", @"MainMenu", @"Drag file or dictionary here");

    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    NSMutableDictionary* stringAttributes = [NSMutableDictionary dictionaryWithCapacity:2];

    [stringAttributes setObject:[NSFont fontWithName:@"Helvetica" size:30] forKey:NSFontAttributeName];
    [stringAttributes setObject:style forKey:NSParagraphStyleAttributeName];
    [stringAttributes setObject:[NSColor grayColor] forKey:NSForegroundColorAttributeName];
    [text drawInRect:NSMakeRect(0, rect.origin.y/2+30, rect.size.width, rect.size.height/2) withAttributes:stringAttributes];
}

- (NSDragOperation)draggingEntered:(id < NSDraggingInfo >)sender {
    self.isHighlight = YES;
    [self setNeedsDisplay:YES];
    return NSDragOperationGeneric;
}

- (NSDragOperation)draggingUpdated:(id < NSDraggingInfo >)sender {
    return NSDragOperationGeneric;
}

- (void)draggingExited:(id < NSDraggingInfo >)sender {
    self.isHighlight = NO;
    [self setNeedsDisplay:YES];
}

- (BOOL)prepareForDragOperation:(id < NSDraggingInfo >)sender {
    self.isHighlight = NO;
    [self setNeedsDisplay:YES];
    return YES;
}

- (BOOL)performDragOperation:(id < NSDraggingInfo >)sender {
    NSPasteboard* pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray* files = [pboard propertyListForType:NSFilenamesPboardType];
        // Perform operation using the list of files
        for (id file in files) {
            [openerDelegate performSelector:@selector(xattrCommandWithPath:FileType:) withObject:file withObject:[NSNumber numberWithBool:[self checkIsDictionaryAt:file]]];
        }
    }
    return YES;
}

- (BOOL)checkIsDictionaryAt:(NSString*) path {
    NSException* exception;
    NSFileManager* fileManager;
    BOOL ret = NO;
    
    fileManager = [NSFileManager defaultManager];
    
    /* If it's not a exist file or dictionary,
       we should throw an exception.*/

    @try {
        if (![fileManager fileExistsAtPath:path isDirectory:&ret]) {
            exception = [NSException exceptionWithName:@"FilesOrDictionariesNotExistException" reason:@"The files or dictionaries are not exist!" userInfo:nil];
            @throw exception;
        }
    }
    @catch (NSException* exception){
        NSLog(@"Caught exception:%@, reason:%@.", [exception name], [exception reason]);
    }
    
    return ret;
}

@end
