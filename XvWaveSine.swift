//
//  XvSine.swift
//  XvSynth
//
//  Created by Jason Snell on 9/29/20.
//

import Foundation
import XvDataMapping

//https://www.mathsisfun.com/algebra/amplitude-period-frequency-phase-shift.html

/*
 y = A sin(B(x + C)) + D
 
 amplitude is A
 period is 2π/B
 phase shift is C (positive is to the left, negative to the right)
 vertical shift is D
 
 */


public class XvWaveSine:XvWave {
    
    //MARK: - Accessors -
    
    //MARK: Sine cycle
    //math constant
    fileprivate let SINE_CYCLE:Double = 2.0 * Double.pi
    

    //MARK: Init
    
    public override init(timeInterval:TimeInterval, amplitudeResistance:Double = 0.1, roundTo:Double = 10000){
        
        super.init(timeInterval: timeInterval, amplitudeResistance: amplitudeResistance, roundTo: roundTo)
    }
    
    //MARK: - calculations
    
    //current wave with phase shift
    public override func refresh() {
        
        super.refresh()
        
        let sineWave:Double = _amplitude * sin(SINE_CYCLE * _frequency * _seconds + _phaseShift)
        
        /*print("")
        print("amp", _amplitude)
        print("frq", _frequency)
        print("shf", withPhaseShift)
        print("result", Double(Int(sineWave * _roundTo)) / _roundTo)*/
        //round it
        _value = Double(Int(sineWave * _roundTo)) / _roundTo
        
    }
}
