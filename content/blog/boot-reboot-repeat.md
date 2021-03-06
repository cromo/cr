---
title: "Boot, reboot, repeat"
date: 2016-05-30T00:00:00-05:00
tags: [hardware, troubleshooting]

status: in progress
belief: log
---
It'd been a good run. The first computer I built, Amethyst, appeared to finally be dying after nearly five years of service. This is the tale of bringing it back from the brink.

I had left my computer on during the day for a number of years in case I need to get something from it when away from home. One day at work, my girlfriend calls and tells me that my computer keeps rebooting itself. I tell her to turn it off and I'll have a look at it when I get home.

I get off work and head home, intriged as to what was causing my computer to finally start blinking out. I turn it on and sure enough, it resets itself while windows is booting. I wait for it to try booting again on its own, and it does the same thing.

I decided to turn the system off and wait a while before trying again. I have had heat issues in the past due to the heatsink not being seated properly. The symptoms were similar - sudden shutdowns.

In one of the next few boots, I manage to make it all the way into Windows, where I can use [SpeedFan](http://www.almico.com/speedfan.php) to check the system temperatures. All normal. Well, the system hadn't rebooted yet, so I took the opportunity to check the other stats that SpeedFan monitors, including the hard drive S.M.A.R.T. info. No warnings or errors anywhere to be seen. Then - you guessed it - the system rebooted again.

My next thought was to boot into the BIOS to see if it detects any hardware issues. I do so, then start poking around the interface to see if it can give me any diagnostics. Suddenly, the screen turns black and I hear the system fans power down and spinning up again. Well, that tells me it's not an issue with Windows.

While I'm confident that Windows itself isn't causing the problem, I still suspect that the drive it's installed on may be causing the issues. To eliminate it as a possible cause, I pull the data and power cables for the drive. While I was pulling cables, I disconnect the other disk drive and the two optical drive cables for good measure. I press the power button and wait for a reboot.

It appears stable for a minute, but suddenly it reboots itself. It's not the drives.

At this point I figure it is likely a bad stick of RAM. I try removing all six sticks and start testing them one by one. Each one exhibits the same behavior.

At this point I start to get worried that my CPU or motherboard is going out. But before I can worry about that, I needed to test the power supply. Unfortunately, I didn't have any spares laying around, and asking friends in the area came up empty. One of them worked at a computer repair shop and said that he'd ask his manager if we could try swapping out my power supply with their test spare when he was off work.

A few days later, we got the okay to come in and try the swap. After opening up the box and swapping out the sprawling power cables, we boot the system. Watching the boot on one of their monitors, we jump into the BIOS to check whether the system is stable. To our surprise, it appears to be working just fine, so we declare that I needed a new power supply.

Suddenly, it reboots.

Now my worst fears have been realized - there aren't many other pieces left to rule out. It must be the motherboard or processor. I search around online to find that processors and motherboards for the socket I chose haven't come down in price much; they were still hovering around $250-$300 about five years later.

I decided to shelf the computer for a few weeks to focus on other obligations. During that time, I figured I may as well try a new motherboard *and* processor so that I could change the socket type to something more future-proof. I did some research and found a decent motherboard with a socket that supported all the way from mid-level i3s all the way up to nice i7s. Committing, I ordered the parts and patiently wait them to come in.

Once they arrived, I opened up the case and performed the transplant. Before closing up the patient, I hooked it up to a monitor and pressed the power button.

The new motherboard's splash screen appeared, and it continued on into the Windows boot process. Apparently out of the woods, I start to put the side panel back on.

Reboot.

Okay, so it wasn't the motherboard or processor. There were only two parts left that hadn't been eliminated: the graphics card and the case.

Knowing that a bad graphics card can bring down a whole build, I took it out of the system completely. I couldn't do that with the other motherboard because it didn't have integrated graphics. I booted the system again and waited.

Reboot.

That left only the case as the possible culprit. After some pacing back and forth wondering what the problem could be, a light turned on - is it possible my reset switch is flakey?

I go back into the case and find the case headers on the motherboard, locate and disconnect the reset lines. I press the power button and wait as the system whirrs to life.

Okay, got past the BIOS.

Made it past the Windows boot into System Recovery.

Cross my fingers and wait five minutes.

It appears to be stable. What a simple thing to bring a system down! I attempt to perform the Windows recovery. It fails, probably due to the massive number of reboots the system suffered, some of them occurring during attempted recoveries.

Let this be a lesson - even the simple components can fail and wreak havoc on a system.

Oh well, I suppose. This gives me an excellent excuse to test drive a linux desktop; may as well make use of it. In the end, I transplanted the old motherboard back into the system and left the reset switch disconnected. Amethyst lived on for a few more months beforefinally kicking the bucket.
