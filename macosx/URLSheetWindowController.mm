// This file Copyright © 2011-2022 Transmission authors and contributors.
// It may be used under the MIT (SPDX: MIT) license.
// License text can be found in the licenses/ folder.

#import "URLSheetWindowController.h"
#import "Controller.h"

@interface URLSheetWindowController ()

- (void)updateOpenButtonForURL:(NSString*)string;

@end

@implementation URLSheetWindowController

NSString* urlString = nil;

- (instancetype)initWithController:(Controller*)controller
{
    if ((self = [self initWithWindowNibName:@"URLSheetWindow"]))
    {
        fController = controller;
    }
    return self;
}

- (void)awakeFromNib
{
    fLabelField.stringValue = NSLocalizedString(@"Internet address of torrent file:", "URL sheet label");

    if (urlString)
    {
        fTextField.stringValue = urlString;
        [fTextField selectText:self];

        [self updateOpenButtonForURL:urlString];
    }

    fOpenButton.title = NSLocalizedString(@"Open", "URL sheet button");
    fCancelButton.title = NSLocalizedString(@"Cancel", "URL sheet button");

    [fOpenButton sizeToFit];
    [fCancelButton sizeToFit];

    //size the two buttons the same
    NSRect openFrame = fOpenButton.frame;
    openFrame.size.width += 10.0;
    NSRect cancelFrame = fCancelButton.frame;
    cancelFrame.size.width += 10.0;

    if (NSWidth(openFrame) > NSWidth(cancelFrame))
    {
        cancelFrame.size.width = NSWidth(openFrame);
    }
    else
    {
        openFrame.size.width = NSWidth(cancelFrame);
    }

    openFrame.origin.x = NSWidth(self.window.frame) - NSWidth(openFrame) - 20.0 + 6.0; //I don't know why the extra 6.0 is needed
    fOpenButton.frame = openFrame;

    cancelFrame.origin.x = NSMinX(openFrame) - NSWidth(cancelFrame);
    fCancelButton.frame = cancelFrame;
}

- (void)openURLEndSheet:(id)sender
{
    [self.window orderOut:sender];
    [NSApp endSheet:self.window returnCode:1];
}

- (void)openURLCancelEndSheet:(id)sender
{
    [self.window orderOut:sender];
    [NSApp endSheet:self.window returnCode:0];
}

- (NSString*)urlString
{
    return fTextField.stringValue;
}

- (void)controlTextDidChange:(NSNotification*)notification
{
    [self updateOpenButtonForURL:fTextField.stringValue];
}

- (void)updateOpenButtonForURL:(NSString*)string
{
    BOOL enable = YES;
    if ([string isEqualToString:@""])
    {
        enable = NO;
    }
    else
    {
        NSRange prefixRange = [string rangeOfString:@"://"];
        if (prefixRange.location != NSNotFound && string.length == NSMaxRange(prefixRange))
        {
            enable = NO;
        }
    }

    fOpenButton.enabled = enable;
}

@end
