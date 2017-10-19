#
#  AppDelegate.rb
#  StopWatch
#
#  Created by Tanner Welsh on 9/7/13.
#  Copyright 2013 __MyCompanyName__. All rights reserved.
#

class AppDelegate
    attr_accessor :window, :textField
    
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end
    
    def toggleTimer(sender)
        if @timer.nil?
            @time = 0.0
            @timer = NSTimer.scheduledTimerWithTimeInterval(0.1,
                                                            target: self,
                                                            selector: "timerHandler:",
                                                            userInfo: nil,
                                                            repeats: true)
        else
            @timer.invalidate
            @timer = nil
            resetTimer
        end
    end
    
    def timeString
        sprintf("%.1f", @time)
    end
    
    def resetTimer
        textField.setTitle("Start")
    end
    
    def timerHandler(userInfo)
        @time += 0.1
        textField.setTitle(timeString)
    end
end

