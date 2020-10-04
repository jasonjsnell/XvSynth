//
//  XvSine.swift
//  XvSynth
//
//  Created by Jason Snell on 9/29/20.
//

import Foundation
import XvDataMapping

public class XvWaveSine {
    
    
    //MARK: - Accessors -
    
    //standard -1.0 to 1.0
    public var value:Double {
        get { return _calculateSine() }
    }
    
    public func value(withPhaseShift:Double) -> Double {
        return _calculateSine(withPhaseShift: withPhaseShift)
    }
    
    // instead of -1.0 to 1.0, it alters it 0.0-1.0
    public var zeroBaseline:Double {
        get { return (value + amplitude) / 2.0 }
    }
    
    //MARK: - Variables
    //MARK: Time
    //time interval needs to match the timeInterval of the Timer object that is firing / refreshing this object
    //that way the seconds variable matches "real" time
    fileprivate var _seconds:Double = 0.0
    fileprivate var _timeInterval:Double = 0.1
    
    //MARK: Sine cycle
    //math constant
    fileprivate let SINE_CYCLE:Double = 2.0 * Double.pi
    
    //MARK: Frequency
    //if frequency is 1.0, then the sine wave will cycle one cycle per second
    //faster frequencies require very fast timeIntervals / timer fires, otherwise it only catches the wave at 1.0 or 0.0 when it renders
    //to get slow, LFO type sine waves, move the frequency down to 0.1 and lower
    
    fileprivate var _frequency:Double // = 0.1
    public var frequency:Double {
        get { return _frequency }
        set {
            if (newValue > _timeInterval) {
                print("XvSine: Error: If frequency is higher than the timeInterval, then the sine wave will lose resolution. For higher frequencies, create a faster Timer and timeInterval.")
            }
            _frequency = newValue
        }
    }
    
    //MARK: Amplitude
    //height of the wave
    //default is 1.0, but can be any value
    fileprivate var _amplitude:Double = 1.0
    
    public var amplitude:Double {
        get { return _amplitude }
        set { _amplitude = newValue }
    }
    
    //MARK: Rounding
    fileprivate var _roundTo:Double = 100000
    
    //MARK: Init
    
    public init(timeInterval:TimeInterval, amplitudeResistance:Double = 0.1, roundTo:Double = 10000){
        
        self._timeInterval = Double(timeInterval)
        
        //matching the frequency to the time interval will default the sine wave to go through one cycle per second
        self._frequency = _timeInterval
        
        self._roundTo = roundTo
        
    }
    
    //MARK: - Refresh
    //https://www.mathsisfun.com/algebra/amplitude-period-frequency-phase-shift.html
    /*
     y = A sin(B(x + C)) + D
     
     amplitude is A
     period is 2π/B
     phase shift is C (positive is to the left, negative to the right)
     vertical shift is D
     
     */
    public func refresh(){
        
        //update time interval
        _seconds += _timeInterval
        
    }
    
    //MARK: - calculations
    //current sine wave
    fileprivate func _calculateSine() -> Double {
        
        let sineWave:Double = _amplitude * sin(SINE_CYCLE * _frequency * _seconds)
        
        //round it
        return Double(Int(sineWave * _roundTo)) / _roundTo
    }
    
    //current wave with phase shift
    fileprivate func _calculateSine(withPhaseShift:Double) -> Double {
        
        let sineWave:Double = _amplitude * sin(SINE_CYCLE * _frequency * _seconds + withPhaseShift)
        
        //round it
        return Double(Int(sineWave * _roundTo)) / _roundTo
        
    }
}
