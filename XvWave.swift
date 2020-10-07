//
//  XvWave.swift
//  XvSynth
//
//  Created by Jason Snell on 10/5/20.
//

import Foundation

public class XvWave {
    
    
    //MARK: - Accessors -
    
    //standard -1.0 to 1.0
    public var value:Double {
        get { return _generateWave() }
    }
    //with phase shift
    public func value(withPhaseShift:Double) -> Double {
        return _generateWave(withPhaseShift: withPhaseShift)
    }
    
    // instead of -1.0 to 1.0, it alters it 0.0-1.0
    public var zeroBaseline:Double {
        get { return (value + amplitude) / 2.0 }
    }
    //with phase shift
    public func zeroBaseline(withPhaseShift:Double) -> Double {
        return (value(withPhaseShift:withPhaseShift) + amplitude) / 2.0
    }
    
    //MARK: - Variables
    //MARK: Time
    //time interval needs to match the timeInterval of the Timer object that is firing / refreshing this object
    //that way the seconds variable matches "real" time
    internal var _seconds:Double = 0.0
    fileprivate var _timeInterval:Double = 0.1
    
    //MARK: Frequency
    //if frequency is 1.0, then the sine wave will cycle one cycle per second
    //faster frequencies require very fast timeIntervals / timer fires, otherwise it only catches the wave at 1.0 or 0.0 when it renders
    //to get slow, LFO type sine waves, move the frequency down to 0.1 and lower
    
    internal var _frequency:Double // = 0.1
    public var frequency:Double {
        get { return _frequency }
        set {
            if (newValue > _timeInterval) {
                print("XvWave: Error: frequency", newValue,  "is higher than the timeInterval", _timeInterval, ", so sine wave will lose resolution. For higher frequencies, create a faster Timer and timeInterval.")
            }
            _frequency = newValue
        }
    }
    
    //MARK: Amplitude
    //height of the wave
    //default is 1.0, but can be any value
    internal var _amplitude:Double = 1.0
    
    public var amplitude:Double {
        get { return _amplitude }
        set { _amplitude = newValue }
    }
    
    //MARK: Rounding
    internal var _roundTo:Double = 100000
    
    public init(timeInterval:TimeInterval, amplitudeResistance:Double = 0.1, roundTo:Double = 10000){
        
        self._timeInterval = Double(timeInterval)
        
        //matching the frequency to the time interval will default the sine wave to go through one cycle per second
        self._frequency = _timeInterval
        
        self._roundTo = roundTo
        
    }
    
    //MARK: - Refresh
    
    
    public func refresh(){
        
        //update time interval
        _seconds += _timeInterval
        
    }
    
    //MARK: - calculations
    //current sine wave
    internal func _generateWave() -> Double {
        
        return _generateWave(withPhaseShift: 0)
    }
    
    //current wave with phase shift
    internal func _generateWave(withPhaseShift:Double) -> Double {
        
        //calc wave here
        //example: let sineWave:Double = _amplitude * sin(SINE_CYCLE * _frequency * _seconds + withPhaseShift)
        
        let wave:Double = 0
        
        //round it
        return Double(Int(wave * _roundTo)) / _roundTo
        
    }
}
