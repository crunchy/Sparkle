//
//  SUScheduledUpdateDriver.m
//  Sparkle
//
//  Created by Andy Matuschak on 5/6/08.
//  Copyright 2008 Andy Matuschak. All rights reserved.
//

#import "SUScheduledUpdateDriver.h"
#import "SUUpdater.h"

#import "SUAppcast.h"
#import "SUAppcastItem.h"
#import "SUVersionComparisonProtocol.h"

@implementation SUScheduledUpdateDriver

- (void)didFindValidUpdate
{
	showErrors = YES; // We only start showing errors after we present the UI for the first time.
	[super didFindValidUpdate];
}

- (void)didNotFindUpdate
{
	if ([[updater delegate] respondsToSelector:@selector(updaterDidNotFindUpdate:)])
		[[updater delegate] updaterDidNotFindUpdate:updater];
	[self abortUpdate]; // Don't tell the user that no update was found; this was a scheduled update.
}

- (void)abortUpdateWithError:(NSError *)error
{
	if (showErrors) {
		[super abortUpdateWithError:error];
	} else {
		if ([[updater delegate] respondsToSelector:@selector(updaterDidAbortWithError:)])
			[[updater delegate] updaterDidAbortWithError:error];
		[self abortUpdate];
	}
}

@end
